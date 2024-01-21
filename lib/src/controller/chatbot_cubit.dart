
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class ChatBotCubit extends Cubit<ChatBotState>{
  ChatBotCubit(): super(InitialChatBotState()){}
  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Future <dynamic> sendMessage(String message) async{
    String chatBotResponse;
    try{
      emit(LoadingChatBotState());
      var response = (await _api.getChatbotApi().getResponseApiChatbotChatGet(query: message))!.data;
      if(response ==null){
        emit(ErrorChatBotState());
      }
      else{
        chatBotResponse= response;
        emit(LoadedChatBotState(chatBotResponse));
      }
    }  on DioException catch(e){
      if(e.response!.statusCode==401 && e.response!=null){
        emit(ErrorChatBotState());
      }
      else{
        emit(ErrorChatBotState());
        print("CHATBOT ERROR $e");
      }
      print("CHATBOT ERROR $e");
    }
  }

}

abstract class ChatBotState{}
class InitialChatBotState extends ChatBotState{}

class LoadingChatBotState extends ChatBotState{}

class LoadedChatBotState extends ChatBotState{
  final String ?chatBotResponse;
  LoadedChatBotState(this.chatBotResponse);
}

class ErrorChatBotState extends ChatBotState{}