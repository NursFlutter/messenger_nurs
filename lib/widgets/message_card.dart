import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messenger_nurs/api/apis.dart';
import 'package:messenger_nurs/helper/my_date_util.dart';

import '../main.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  // sender or another user message
  Widget _blueMessage() {
    // update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      log('message read updated');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.message.msg,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Text(
                  MyDateUtil.getFormattedTime0(
                      context: context, time: widget.message.sent),
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.message.msg,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      MyDateUtil.getFormattedTime0(
                          context: context, time: widget.message.sent),
                      style:
                          const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    const SizedBox(width: 5),
                    if (widget.message.read.isNotEmpty)
                      const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
