import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/states/authentication_state.dart';
import 'package:pharmaease/src/data/constants.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState()) {}

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();
  final FlutterSecureStorage _secureStorage =
      GetIt.I.get<FlutterSecureStorage>();

  void expireSession() {
    _secureStorage.delete(key: USER_TOKEN_KEY);
    emit(UnauthenticatedState());
  }

  Future<void> signUp(User user) async {
    try {
      emit(LoadingAuthenticationState());
      String? response =
          (await _api.getAuthApi().createUserAuthRegisterPost(user: user)).data;
      if (response == "User already registred") {
        emit(AlreadyRegisteredState());
      }
      if (response == "User created successfully.") {
        emit(SuccessfullyRegisteredState());
      }
    } catch (e) {
      emit(FailedAuthenticationState());
    }
  }

  Future<void> signIn(String username, String password) async {
    try {
      emit(LoadingAuthenticationState());
      String? token = (await _api.getAuthApi().loginForAccessTokenAuthTokenPost(
              username: username, password: password))
          .data;
      if (token == null) {
        emit(FailedAuthenticationState());
      } else{
      await _secureStorage.write(key: USER_TOKEN_KEY, value: token);
      emit(AuthenticatedState(token: token));
      }
    } catch(e) {
      emit(FailedAuthenticationState());
    }
  }

  Future<String?> getToken() async {
    String? token = await _secureStorage.read(key: USER_TOKEN_KEY);
    if(token == null || token.isEmpty) {
      emit(UnauthenticatedState());
    }
    else {
      emit(AuthenticatedState(token: token));
      return token;
    }
  }

}
