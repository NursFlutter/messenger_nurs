import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_nurs/api/apis.dart';
import 'package:messenger_nurs/consts/color_string.dart';
import 'package:messenger_nurs/screens/auth/login_screen.dart';

import '../helper/dialogs.dart';
import '../main.dart';
import '../models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Profile"),
        shape: const Border(bottom: BorderSide(width: 1)),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),

        // sign out from app
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await APIs.auth.signOut().then(
              (value) async {
                await GoogleSignIn().signOut().then(
                  (value) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  },
                );
              },
            );
          },
          icon: const Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: Column(
          children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * 1),
                  child: CachedNetworkImage(
                    width: mq.height * .2,
                    height: mq.height * .2,
                    imageUrl: widget.user.image,
                    fit: BoxFit.fill,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(Icons.person)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: MaterialButton(
                    elevation: 1,
                    onPressed: () {},
                    shape: const CircleBorder(),
                    color: nWhiteColor,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: mq.height * .03),
            Text(
              widget.user.email,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(width: mq.width, height: mq.height * .05),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Name',
                  label: Text('Name')),
            ),
            SizedBox(width: mq.width, height: mq.height * .02),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.info_outline, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'About',
                  label: Text('About')),
            ),
            SizedBox(width: mq.width, height: mq.height * .05),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(mq.width * .4, mq.height * .045)),
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text('UPDATE'),
            )
          ],
        ),
      ),
    );
  }
}
