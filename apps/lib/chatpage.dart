import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String userName;

  const ChatPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildMessageBubble('Hi! How are you?', true),
                _buildMessageBubble('I\'m good, thanks! How about you?', false),
                _buildMessageBubble(
                    'Doing well, just working on some projects.', true),
                // Add more message bubbles here...
              ],
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  // Helper function to build message bubbles
  Widget _buildMessageBubble(String message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  // Input field for sending messages
  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Add send functionality here
            },
          ),
        ],
      ),
    );
  }
}
