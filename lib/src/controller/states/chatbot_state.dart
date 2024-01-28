abstract class ChatBotState {}

class InitialChatBotState extends ChatBotState {}

class LoadingChatBotState extends ChatBotState {}

class LoadedChatBotState extends ChatBotState {
  final String? chatBotResponse;

  LoadedChatBotState(this.chatBotResponse);
}

class ErrorChatBotState extends ChatBotState {}
