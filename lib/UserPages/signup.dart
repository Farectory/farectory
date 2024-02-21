import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:farectory/UserPages/login.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String dateOfBirth = 'Date of Birth';
  String? phoneNumber;
  String? country;
  String? state;
  String? city;

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

  final textFieldFocusNode1 = FocusNode();
  bool _obscured1 = true;

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

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
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.white, Colors.blue])),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Lottie.asset('images/signup_animation.json', height: 150),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Column(
                      children: [
                        Text(
                          'SIGNUP',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Stepper(
                            onStepCancel: () {
                              if (_currentStep != 0) {
                                setState(() {
                                  _currentStep -= 1;
                                });
                              } else {
                                null;
                              }
                            },
                            currentStep: _currentStep,
                            onStepTapped: (value) {
                              setState(() {
                                _currentStep = value;
                              });
                            },
                            type: StepperType.horizontal,
                            steps: [
                              Step(
                                  isActive: _currentStep == 0,
                                  title: Text('Personal'),
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            hintText: "Full Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                            fillColor:
                                                Color.fromARGB(24, 10, 188, 237),
                                            filled: true,
                                            prefixIcon: const Icon(Icons.person)),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100))
                                              .then((value) {
                                            setState(() {
                                              dateOfBirth =
                                                  '${value!.day.toString()}-${value.month.toString()}-${value.year.toString()}';
                                            });
                                          });
                                        },
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintText: dateOfBirth,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                            fillColor:
                                                Color.fromARGB(24, 10, 188, 237),
                                            filled: true,
                                            prefixIcon: const Icon(
                                                Icons.calendar_today_outlined)),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      IntlPhoneField(
                                        decoration: const InputDecoration(
                                          fillColor:
                                              Color.fromARGB(24, 10, 188, 237),
                                          filled: true,
                                          labelText: 'Phone Number',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        initialCountryCode: 'NG',
                                        onChanged: (phone) {
                                          country = phone.countryCode;
                                          phoneNumber = phone.completeNumber;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CSCPicker(
                                        defaultCountry: CscCountry.Nigeria,
                                        searchBarRadius: 30,
                                        onCountryChanged: (value) {
                                          setState(() {
                                            value;
                                          });
                                        },
                                        // disableCountry: true,
                                        onCityChanged: (value) {
                                          city = value;
                                        },
                                        onStateChanged: (value) {
                                          state = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )),
                              Step(
                                  isActive: _currentStep == 1,
                                  title: Text('Authentication'),
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if (value!.contains('@') == false ||
                                                value.contains('.') == false) {
                                              return 'Invalid email address';
                                            }
                                            return null;
                                          },
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  borderSide: BorderSide.none),
                                              fillColor: const Color.fromARGB(
                                                  24, 10, 188, 237),
                                              filled: true,
                                              prefixIcon:
                                                  const Icon(Icons.email)),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          validator: (value) {
                                            if (value!.length < 6) {
                                              return 'Password must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                          focusNode: textFieldFocusNode,
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                            fillColor: const Color.fromARGB(
                                                24, 10, 188, 237),
                                            filled: true,
                                            prefixIcon:
                                                const Icon(Icons.password),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 0, 4, 0),
                                              child: GestureDetector(
                                                onTap: _toggleObscured,
                                                child: Icon(
                                                  _obscured
                                                      ? Icons.visibility_rounded
                                                      : Icons
                                                          .visibility_off_rounded,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          obscureText: _obscured,
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          validator: (value) {
                                            if (value !=
                                                passwordController.text) {
                                              return 'Password mismatch!';
                                            }
                                            return null;
                                          },
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          focusNode: textFieldFocusNode1,
                                          controller: passwordConfirmController,
                                          decoration: InputDecoration(
                                            hintText: "Confirm Password",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide.none),
                                            fillColor: const Color.fromARGB(
                                                24, 10, 188, 237),
                                            filled: true,
                                            prefixIcon:
                                                const Icon(Icons.password),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 0, 4, 0),
                                              child: GestureDetector(
                                                onTap: _toggleObscured1,
                                                child: Icon(
                                                  _obscured1
                                                      ? Icons.visibility_rounded
                                                      : Icons
                                                          .visibility_off_rounded,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          obscureText: _obscured1,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                            onStepContinue: () async {
                              if (_currentStep == 0) {
                                setState(() {
                                  _currentStep += 1;
                                });
                              } else if (_currentStep == 1) {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    dateOfBirth != 'Date of Birth' &&
                                    nameController.text.isNotEmpty &&
                                    phoneNumber != null &&
                                    city != null &&
                                    state != null) {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    await FirebaseAnalytics.instance
                                        .logEvent(name: 'sign_up');
                                    FirebaseAuth.instance.currentUser
                                        ?.updateDisplayName(nameController.text);
                  
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(
                                            '${FirebaseAuth.instance.currentUser!.email}')
                                        .set({
                                      'UserID':
                                          FirebaseAuth.instance.currentUser?.uid,
                                      'Name': nameController.text,
                                      'Email': emailController.text.trim(),
                                      'Joined':
                                          FieldValue.serverTimestamp(),
                                        'AccountCreated':  DateFormat('K:mm a, M/d/y').format(DateTime.now()),
                                      'DateOfBirth': dateOfBirth,
                                      'PhoneNumber': phoneNumber,
                                      'Country': country,
                                      'AccountType': 'Preliminary',
                                      'Location': '$city, $state'
                                    });
                                    FirebaseAuth.instance.currentUser
                                        ?.sendEmailVerification();
                                    showToast(
                                        'Account Created Successfully! Kindly proceed to login',
                                        5,
                                        Icons.check_circle,
                                        const Color.fromRGBO(37, 211, 102, 1));
                                    Navigator.of(context).pop();
                                  } on FirebaseAuthException catch (error) {
                                    if (error.code == 'email-already-in-use') {
                                      showToast(
                                          'User already exists! Kindly return to login page or reset your password',
                                          5,
                                          Icons.info,
                                          Colors.red);
                                    }
                                    if (error.code == 'invalid-email') {
                                      showToast(
                                          'Invalid email address! Check your email address and try again',
                                          3,
                                          Icons.info,
                                          Colors.red);
                                    } else if (error.code == 'weak-password') {
                                      showToast(
                                          'Weak password. Password must be a least 6 characters long',
                                          3,
                                          Icons.info,
                                          Colors.red);
                                    } else {
                                      showToast(
                                          'An error has occured please try again',
                                          3,
                                          Icons.info,
                                          Colors.red);
                                    }
                                  }
                                } else {
                                  showToast('All fields are required...', 3,
                                      Icons.info, Colors.red);
                                }
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text('Already have an account?'),
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
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
