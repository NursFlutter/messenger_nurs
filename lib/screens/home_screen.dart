import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_nurs/api/apis.dart';
import 'package:messenger_nurs/screens/profile_screen.dart';
import 'package:messenger_nurs/widgets/chat_user_card.dart';

import '../main.dart';
import '../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Text("Nurs Messenger"),
        shape: Border(bottom: BorderSide(width: 1)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.home_max)),
          // search user button
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),

          // more features button
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: APIs.me)));
          }, icon: Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),

        // button to add new user
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.getALlUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                if(list.isNotEmpty){
                  return ListView.builder(
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(user: list[index],);
                      });
                } else {
                  return Center(child: Text('No Connections Found', style: TextStyle(fontSize: 20),));
            }
          }})
    );
  }
}
