import 'package:flutter/material.dart';

import '../consts/color_string.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? nGreenColor : nGrey600Color,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
      child: Text(message, style: TextStyle(color: nWhiteColor),),
    );
  }
}
