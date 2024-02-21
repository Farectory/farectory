import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestReviewPage extends StatefulWidget {
  const RequestReviewPage({super.key});

  @override
  State<RequestReviewPage> createState() => _RequestReviewPageState();
}

class _RequestReviewPageState extends State<RequestReviewPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController tenureController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController sizeController = new TextEditingController();
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
            color: Colors.white,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text('Request Review',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(24, 10, 188, 237),
                    filled: true,
                    prefixIcon: const Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                    hintText: "Location",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(24, 10, 188, 237),
                    filled: true,
                    prefixIcon: const Icon(Icons.location_on)),
              ),
              SizedBox(height: 10),
              TextField(
                controller: tenureController,
                decoration: InputDecoration(
                    hintText: "Tenure e.g Lease or Sale ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(24, 10, 188, 237),
                    filled: true,
                    prefixIcon: const Icon(Icons.landscape)),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: "Phone number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(24, 10, 188, 237),
                    filled: true,
                    prefixIcon: const Icon(Icons.phone)),
              ),
              SizedBox(height: 10),
              TextField(
                controller: sizeController,
                decoration: InputDecoration(
                    hintText: "Size",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(24, 10, 188, 237),
                    filled: true,
                    prefixIcon: const Icon(Icons.numbers)),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.blue),
                  onPressed: () async {
                    final random = new Random().nextInt(1000000);

                    if (nameController.text.isNotEmpty &&
                        locationController.text.isNotEmpty &&
                        sizeController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        tenureController.text.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('ReviewRequests')
                          .doc('${FirebaseAuth.instance.currentUser!.email}$random')
                          .set({
                        'Name': nameController.text,
                        'Location': locationController.text,
                        'Tenure': tenureController.text,
                        'Phone': phoneController.text,
                        'Sizes': sizeController.text,
                        'UserID': FirebaseAuth.instance.currentUser!.uid
                      });
                      nameController.clear();
                      tenureController.clear();
                      phoneController.clear();
                      sizeController.clear();
                      locationController.clear();

                      showToast(
                          'Request submitted successfully. We will reach out to you shortly',
                          7,
                          Icons.check_circle,
                          const Color.fromRGBO(37, 211, 102, 1));
                    } else {
                      showToast(
                          'All fields are required', 3, Icons.info, Colors.red);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
