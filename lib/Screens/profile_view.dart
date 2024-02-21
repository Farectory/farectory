// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Screens/user_chat_screen.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileViewPage extends StatefulWidget {
  final String? profileName;
  final String? bio;
  final String? imagePath;
  final String? userID;
  final String? workExperience;
  final String? location;
  const ProfileViewPage(
      {super.key,
      this.profileName,
      this.imagePath,
      this.bio,
      this.location,
      this.userID,
      this.workExperience});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  IconData bookmark = Icons.bookmark_add_outlined;

    late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  showToast(String message, int time, IconData icon, Color color) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: color),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          SizedBox(
            width: 200,
            child: Text(
              message,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: time),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profileName!),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                height: 300,
                child: Stack(children: [
                  Image.network(
                    widget.imagePath!,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fromRelativeRect(
                      rect: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width * 0.85, -220, 5, 10),
                      child: IconButton(
                        onPressed: () async {
                          if (bookmark == Icons.bookmark_add_outlined) {
                            setState(() {
                              bookmark = Icons.bookmark_added;
                            });
                            await FirebaseFirestore.instance
                                .collection('Bookmark')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('Bookmarked')
                                .add({
                              'Name': widget.profileName!,
                              'ImageURL': widget.imagePath!,
                              'WorkExperience': widget.workExperience,
                              'Location': widget.location
                            }).then((value) {
                              showToast('Bookmark added successfully', 3,
                                  Icons.check_circle, Colors.green);
                            });
                          } else if (bookmark == Icons.bookmark_added) {
                            setState(() {
                              bookmark = Icons.bookmark_add_outlined;
                            });
                            final bookmarked = await FirebaseFirestore.instance
                                .collection('Bookmark')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('Bookmarked')
                                .where('Name', isEqualTo: widget.profileName)
                                .get();
                            final id = bookmarked.docs[0].id;
                            await FirebaseFirestore.instance
                                .collection('Bookmark')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('Bookmarked')
                                .doc(id)
                                .delete()
                                .then((value) {
                              showToast('Bookmark removed successfully', 3,
                                  Icons.check_circle, Colors.red);
                            });
                          }
                        },
                        icon: Icon(
                          bookmark,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ))
                ])),
            Padding(
                padding: const EdgeInsets.all(25),
                child: Text(widget.bio!,
                    style: SafeGoogleFont('Georgia', fontSize: 16.5))),
            Container(
              padding: const EdgeInsets.all(15),
              child: const Column(
                children: [
                  Divider(
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Work Experience'),
                          ],
                        ),
                        Text('2 years')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Gender'),
                          ],
                        ),
                        Text('Male')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Location'),
                          ],
                        ),
                        Text('Lagos, Nigeria')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cast_for_education),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Qualification'),
                          ],
                        ),
                        Text('BSC, Computer Science')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => UserChatScreen(
                                      profileName: widget.profileName!,
                                      imageUrl: widget.imagePath!,
                                      receiverID: widget.userID!,
                                    )));
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.blue),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () async {
                        showToast('Request sent successfully', 3,
                                  Icons.check_circle, Colors.green);
                      },
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Request call',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
