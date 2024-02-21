import 'package:farectory/Screens/forgot_password.dart';
import 'package:farectory/UserPages/signup.dart';
import 'package:farectory/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  Future displayBottomSheet(ImageProvider image) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        barrierColor: Colors.black87.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        builder: ((context) {
          final user = FirebaseAuth.instance.currentUser;
          return Container(
              padding: const EdgeInsets.all(20),
              height: 320,
              width: double.infinity,
              child: Column(
                children: [
                  Center(
                    child: Lottie.asset('images/welcome_animation.json',
                        height: 20),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: image,
                      height: 100.0,
                      fit: BoxFit.fill,
                      width: 100.0,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    user!.displayName ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  const Text('You are now signed in!',
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15)
                ],
              ));
        }));
  }

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
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    )),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(34, 150, 243,1),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70))),
                  child: Center(
                      child: Lottie.asset('images/welcome_login_page.json',
                          height: 200)),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.6667,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.blue)),
            ),
            Align( 
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.667,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70))),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'We have missed you...',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value!.contains('@') == false ||
                              value.contains('.') == false) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        focusNode: textFieldFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Color.fromARGB(24, 95, 159, 228),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        obscureText: _obscured,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.blue),
                          onPressed: () async {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());

                                displayBottomSheet( NetworkImage(
                                   FirebaseAuth.instance.currentUser!.photoURL ?? 'https://cobaltsettlements.com/wp-content/uploads/2019/03/blank-profile.jpg'));
                              } on FirebaseAuthException catch (error) {
                                if (error.code == 'invalid-email') {
                                  showToast(
                                      'Invalid email address! Check your email address and try again',
                                      3,
                                      Icons.info,
                                      Colors.red);
                                } else if (error.code == 'invalid-credential') {
                                  showToast(
                                      'Invalid Credentials. Please check your details and try again',
                                      3,
                                      Icons.info,
                                      Colors.red);
                                } else if (error.code == 'wrong-password') {
                                  showToast(
                                      'Invalid password. Please check and try again',
                                      3,
                                      Icons.info,
                                      Colors.red);
                                } else if (error.code == 'user-not-found') {
                                  showToast(
                                      'User not found. Please a new account instead',
                                      3,
                                      Icons.info,
                                      Colors.red);
                                }
                              }
                            } else {
                              showToast('Email and password are required', 3,
                                  Icons.info, Colors.red);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                          SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => const ForgotPassword()));
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => const SignupPage()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
