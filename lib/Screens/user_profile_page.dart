import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with AutomaticKeepAliveClientMixin {
  var imageURL;
  bool _fields = true;
  bool _button = false;
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

    void uploadImage() async {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 512,
          maxWidth: 512,
          imageQuality: 75);

      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${FirebaseAuth.instance.currentUser!.email}${image!.path}');
      await ref.putFile(File(image.path));
      await ref.getDownloadURL().then((value) {
        setState(() {
          imageURL = value;
        });
        setState(() {});
      });
      final user = FirebaseAuth.instance.currentUser!;
      user.updatePhotoURL(imageURL);
      showToast(
          'Profile picture updated successfully', 3, Icons.info, Colors.green);
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
              )),
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        elevation: 0,
                        title: const Text('Wait a sec!'),
                        content: SizedBox(
                          height: 270,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage(FirebaseAuth
                                              .instance.currentUser?.photoURL ??
                                          'https://cobaltsettlements.com/wp-content/uploads/2019/03/blank-profile.jpg'),
                                      height: 100.0,
                                      fit: BoxFit.fill,
                                      width: 100.0,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  FirebaseAuth
                                          .instance.currentUser?.displayName ??
                                      ' ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(height: 15),
                                const Text('Are you sure you want to logout???',
                                    textAlign: TextAlign.center),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 238, 70, 58)
                                            // fixedSize: Size(250, 50),
                                            ),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance
                                              .signOut()
                                              .whenComplete(() {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyApp()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          });
                                        },
                                        child: const Text(
                                          "Continue",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      )
                                      // }),
                                    ])
                              ],
                            ),
                          ),
                        )));
              },
              icon: const Icon(Icons.logout),
              color: Colors.blue,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /// -- IMAGE
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                      ]),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser?.photoURL ??
                                    "https://cobaltsettlements.com/wp-content/uploads/2019/03/blank-profile.jpg"),
                              )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    uploadImage();
                                  },
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(FirebaseAuth.instance.currentUser?.displayName ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                      const SizedBox(height: 10),
                      Text(FirebaseAuth.instance.currentUser?.email ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _button = !_button;
                          });
                          setState(() {
                            _fields = !_fields;
                          });
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ))
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('UserID',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      List accountdetails = [];
                      final userInfo = snapshot.data!.docs[0];
                      final dob = userInfo.get('DateOfBirth');
                      final phone = userInfo.get('PhoneNumber');
                      final created = userInfo.get('AccountCreated');
                      final type = userInfo.get('AccountType');
                      final location = userInfo.get('Location');

                      accountdetails.add({
                        'dob': dob,
                        'phone': phone,
                        'created': created,
                        'type': type,
                        'location': location,
                      });

                      final account = accountdetails.asMap();

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 2, color: Colors.blue),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ]),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Account type'),
                              ],
                            ),
                            TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: "${account[0]['type']}",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Color.fromARGB(24, 10, 188, 237),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.account_box)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Phone Number'),
                              ],
                            ),
                            TextFormField(
                              controller: _phoneController,
                              // initialValue: "${account[0]['phone']}",
                              readOnly: _fields,
                              decoration: InputDecoration(
                                  hintText: "${account[0]['phone']}",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Color.fromARGB(24, 10, 188, 237),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.phone)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text('Location'),
                              ],
                            ),
                            TextFormField(
                              controller: _locationController,
                              // initialValue:
                              //     "${account[0]['location']}",
                              readOnly: _fields,
                              decoration: InputDecoration(
                                  hintText: "${account[0]['location']}",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Color.fromARGB(24, 10, 188, 237),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.my_location)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Date of birth'),
                              ],
                            ),
                            TextFormField(
                              controller: _dobController,
                              // initialValue: "${account[0]['dob']}",
                              readOnly: _fields,
                              decoration: InputDecoration(
                                  hintText: "${account[0]['dob']}",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Color.fromARGB(24, 10, 188, 237),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.edit_calendar)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text('Date joined'),
                              ],
                            ),
                            TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: "${account[0]['created']}",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide.none),
                                    fillColor: Color.fromARGB(24, 10, 188, 237),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.history))),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: _button,
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2, color: Colors.blue),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .set({
                                        'AccountType': 'Preliminary',
                                        'PhoneNumber': _phoneController.text,
                                        'Location': _locationController.text,
                                        'DateOfBirth': _dobController.text
                                      });
                                      showToast(
                                          'Account information updated successfully',
                                          3,
                                          Icons.info,
                                          Colors.green);
                                      setState(() {
                                        _button = !_button;
                                      });

                                      setState(() {
                                        _fields = !_fields;
                                      });
                                    },
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Submit',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ]),
                                  )),
                            )
                          ]),
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                const Divider(),

                const SizedBox(height: 10),
              ],
            ),
          ),
        )
        // }),
        );
  }
}
