import 'package:flutter/material.dart';
import 'package:couple_app/theme/text_styles.dart';
import 'package:couple_app/theme/color_styles.dart';
import 'package:couple_app/theme/button_styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(text);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(title: Text('chat room', style: bodyStyle)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.Lgreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index], style: bodyStyle,),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'add text...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _sendMessage,
                  child: Text('send', style: bodyStyle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
