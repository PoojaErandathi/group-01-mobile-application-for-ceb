import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ceb_app/reusable_widgets/reusable_widgets.dart';
import 'package:ceb_app/screens/home_screen.dart';
import 'package:ceb_app/screens/signin_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _accNumTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringToColor("720F11"),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              120, // Adjusted the top padding to move the logo up
              20,
              0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter UserName", Icons.person_outline, false,
                      _userNameTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email Id", Icons.email_outlined, false,
                      _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Account No", Icons.wb_iridescent_outlined, false,
                      _accNumTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () {
                    if (_formKey.currentState!.validate()) {
                      _signUpUser();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    try {
      String accountNumber = _accNumTextController.text;
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(accountNumber);

      // Create a new user document
      await userDoc.set({
        'name': _userNameTextController.text,
        'email': _emailTextController.text,
        'password': _passwordTextController.text, // In a real app, hash the password before storing it
        'createdAt': Timestamp.now(),
      });

      // Navigate to home screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(accountNumber: accountNumber),
        ),
      );
    } catch (e) {
      print("Error signing up: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to sign up. Please try again."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
