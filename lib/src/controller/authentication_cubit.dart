import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pharmaease/src/data/constants.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(InitialAuthenticationState()) {
    _init();
  }

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();
  final FlutterSecureStorage _secureStorage = GetIt.I.get<FlutterSecureStorage>();

  void _init() {
    loadToken();
  }

  void authenticate() async {
    emit(LoadingAuthenticationState());

    String? username = await _secureStorage.read(key: USERNAME_KEY);
    String? password = await _secureStorage.read(key: PASSWORD_KEY);

    // NEEDS BACKEND MODIFICATION
    //   try{
    //     if(username != null && password != null) {
    //       requestLogin(username, password, true);
    //     }
    //     else {
    //   emit(const FailedAuthenticationState();
    //   }
    //   catch {}
    // }
  }

  void requestLogin(String username, String password, bool accept) async{
    if(await loadToken()) {return; }

    // NEEDS BACKEND MODIFICATION
    // try {
    //   emit(LoadingAuthenticationState());
    //   User? result = (await
    //   _api.getUserApi().loginApiUserTokenPost(username: username, password: password )).data;
    // }
    // catch {
    //   if(result.statusCode)
    // }
  }

  Future<bool> loadToken() async {
    emit(LoadingAuthenticationState());
    String? token = await _secureStorage.read(key: USER_TOKEN_KEY);

    if (!_isValidToken(token)) {
      emit(UnauthenticatedState());
      return false;
    }
    emit(const AuthenticatedState());
    return true;
  }

  bool _isValidToken(String? token) {
    if (token!.isEmpty) { return false; }
    if (JwtDecoder.tryDecode(token) == null) { return false; }
    if (JwtDecoder.isExpired(token)) { return false; }
    return true;
  }

}


abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState();

  @override
  List<Object> get props => [];
}

class FailedAuthenticationState extends AuthenticationState {
  final String error;
  const FailedAuthenticationState({required this.error});

  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UnknownAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoadingAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationTimedOutState extends AuthenticationState {
  @override
  List<Object> get props => [];
}