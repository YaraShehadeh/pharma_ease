import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmaease/src/controller/chatbot_cubit.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'HomePage/map_page.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  String formattedDate = DateFormat('EEEE,h:mm a').format(DateTime.now());
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    if(text.isNotEmpty) {
      _textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        messageType: MessageType.sent,
        timestamp:
        DateTime.now(), // You can set the message timestamp to current time
      );
      setState(() {
        _messages.insert(0, message);
      });
      final cubit = context.read<ChatBotCubit>().sendMessage(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MapPage()));
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 65),
          child: Text("PharmaBot",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    color: pharmaGreenColor, shape: BoxShape.circle),
              ),
              const Text(
                "Always active",
                style: TextStyle(),
              )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          const Divider(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                formattedDate,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<ChatBotCubit,ChatBotState>(
              builder: (context,state) {
                if(state is LoadingChatBotState){
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is LoadedChatBotState){
                  final responseMessage = ChatMessage(
                      text:state.chatBotResponse??"No response" ,
                      messageType: MessageType.received,
                      timestamp: DateTime.now(),);
                  _messages.insert(0, responseMessage);
                }
                else if(state is ErrorChatBotState){
                  print("ERROR CHATBOT");
                }
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => _messages[index],
                );
              }
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum MessageType { sent, received }

class ChatMessage extends StatelessWidget {
  final String text;
  final MessageType messageType;
  final DateTime timestamp;

  const ChatMessage({
    super.key,
    required this.text,
    required this.messageType,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final isSent = messageType == MessageType.sent;
    return Row(
      mainAxisAlignment:
      isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isSent)
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.android, color: Colors.green),
          ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isSent ? const Color(0xFF4DB6AC) : Colors.grey[300],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSent ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
