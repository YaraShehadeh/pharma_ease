import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmaease/src/controller/cubits/chatbot_cubit.dart';
import 'package:pharmaease/src/controller/states/chatbot_state.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'HomePage/map_page.dart';


class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  String formattedDate = DateFormat('EEEE,h:mm a').format(DateTime.now());
  final TextEditingController _textController = TextEditingController();
  final List<ChatItem> _messages = [];

  void _handleSubmitted(String text)async {
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
      await  context.read<ChatBotCubit>().sendMessage(text);
    }
  }
  @override
  void initState(){
    super.initState();
    ChatMessage initialGreetingMessage= ChatMessage(
        text: "Hello! I'm the official PharmaEase chatBot.How can I assist you today",
        messageType: MessageType.received,
        timestamp: DateTime.now());
    _messages.insert(0, initialGreetingMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
            child: BlocConsumer<ChatBotCubit,ChatBotState>(
              listener: (context,state) {
                if (state is LoadedChatBotState){
                  if(_messages.isNotEmpty &&_messages.first is TypingIndicator){
                    _messages.removeAt(0);
                  }
                  final responseMessage = ChatMessage(
                    text:state.chatBotResponse??"No response" ,
                    messageType: MessageType.received,
                    timestamp: DateTime.now(),);
                  _messages.insert(0, responseMessage);

                }
                else if (state is LoadingChatBotState){
                  _messages.insert(0, const TypingIndicator());
                }

                else if(state is ErrorChatBotState){
                  setState(() {
                    _messages.removeAt(0);
                  });
                }

              }, builder: ( context,  state) {
              return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index){
                    final item= _messages[index];
                    if(item is ChatMessage){
                      return item;
                    }
                    else if(item is TypingIndicator){
                      return const TypingIndicator();
                    }
                  }

              );

            },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: 360,
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

abstract class ChatItem{}
enum MessageType { sent, received }


class ChatMessage extends StatelessWidget implements ChatItem {
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

class TypingIndicator extends StatelessWidget implements ChatItem{
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 20.0, height: 20.0),
        DefaultTextStyle(
            style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Agne',
                color: Colors.black
            ),
            child: AnimatedTextKit(animatedTexts: [
              TyperAnimatedText(
                  'Typing...', speed: const Duration(milliseconds: 100)),
            ], repeatForever: true,))
      ],
    );
  }
}