import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/UserPages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
   TextEditingController emailController = TextEditingController();

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
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    )),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70))),
                  child: Center(child: Lottie.asset('images/forgot_password.json',
                  height: 200)),      
                )
              ],
            ),
            Align(alignment: Alignment.bottomCenter,
            child: Container(
                  height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.blue)
        ),
                ),
        Align(alignment: Alignment.bottomCenter,
            child: Container(
                  height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
          child: Column(
            children: [ 
              Text('Forgot Password?', style: TextStyle(fontSize: 28,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text('Let\'s help you get back in...', style: TextStyle(fontSize: 14,
            ),),
            SizedBox(height: 30),
              TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(24, 95, 159, 228),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),
        
          
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blue
                  ),
                    onPressed: () async {
                      CollectionReference emailRef =
                FirebaseFirestore.instance.collection('Users');
            final value = await emailRef
                .where('Email', isEqualTo: emailController.text.trim())
                .get();
            if (value.docs.isNotEmpty) {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailController.text.trim())
                  .whenComplete(() {
                showToast(
                    'A link to reset your password has been sent successfully to your email address!',
                    5,
                    Icons.check_circle,
                    Colors.blue);
              });
            } else {
              showToast('Invalid email or user not found...', 3,
                  Icons.info, Colors.red);
            }
                    }, 
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.restore, color: Colors.white,),
                      SizedBox(width: 10),
                      Text('Reset Password', style: TextStyle(color: Colors.white),)
                    ],
                  )),
                  SizedBox(height: 15,),
                  Text('Or'),
                  SizedBox(height: 10,),
                  TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => const LoginPage()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.blue),
                              ))
            ],
          ),
        ),
                )
                
          ],
          
        ),
      ),
    );
  }
}
