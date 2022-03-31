import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_receipt/helper/custom_theme.dart';
import 'package:product_receipt/screen/home_screen.dart';
import 'package:product_receipt/screen/registration_screen.dart';
import 'package:product_receipt/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double _headerHeight = 250;

  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: CustomTheme().textInputDecoration(
                                'User Email', 'Enter email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                  .hasMatch(value)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _emailController.text = value!;
                            },
                          ),
                          decoration: CustomTheme().inputBoxDecorationShadow(),
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: CustomTheme().textInputDecoration(
                                'Password', 'Enter password'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password require for Login";
                              }
                              if (!RegExp(r'^.{6,}$').hasMatch(value)) {
                                return "Please Enter Minimum 6 Character";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _passwordController.text = value!;
                            },
                          ),
                          decoration: CustomTheme().inputBoxDecorationShadow(),
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          decoration:
                          CustomTheme().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: CustomTheme().buttonStyle(),
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              //After successful login we will redirect to profile page.
                              signIn(_emailController.text,
                                  _passwordController.text);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const RegistrationScreen()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                  Theme.of(context).colorScheme.secondary),
                            ),
                          ])),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

// login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.pushNamed(context, HomeScreen.id),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        if (kDebugMode) {
          print(error.code);
        }
      }
    }
  }
}
