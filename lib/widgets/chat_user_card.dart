import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:messenger_nurs/consts/color_string.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue.shade100,
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user,)));
        },
        child: ListTile(
          // leading: CircleAvatar(child: Icon(Icons.person)),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .03),
            child: CachedNetworkImage(
              width: mq.height * .045,
              height: mq.height * .045,
              imageUrl: widget.user.image,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                print('Ошибка загрузки изображения: $error');
                return const CircleAvatar(child: Icon(Icons.person));
              },
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1),
          trailing: Container(
            width: 15,
            height: 15, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent.shade400
            ),
          ),
        ),
      ),
    );
  }
}
