import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_receipt/helper/custom_theme.dart';
import 'package:product_receipt/model/user_model.dart';
import 'package:product_receipt/screen/login_screen.dart';
import 'package:product_receipt/widgets/header_widget.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final _firstNameEditingController = TextEditingController();
  final _secondNameEditingController = TextEditingController();
  final _mobileNumberEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _confirmPasswordEditingController = TextEditingController();

  bool checkedValue = false;
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = Container(
      child: TextFormField(
        controller: _firstNameEditingController,
        decoration: CustomTheme()
            .textInputDecoration('First Name', 'Enter your first name'),
        validator: (val) {
          if ((val!.isEmpty)) {
            return "Please enter your first Name";
          }
          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
            return "Enter valid Name";
          }
          return null;
        },
        onSaved: (value) {
          _firstNameEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //second name field
    final secondNameField = Container(
      child: TextFormField(
        controller: _secondNameEditingController,
        decoration: CustomTheme()
            .textInputDecoration('Last Name', 'Enter your last name'),
        validator: (val) {
          if ((val!.isEmpty)) {
            return "Please enter your last Name";
          }
          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
            return "Enter valid Name";
          }
          return null;
        },
        onSaved: (value) {
          _secondNameEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //email field
    final emailField = Container(
      child: TextFormField(
        controller: _emailEditingController,
        decoration: CustomTheme()
            .textInputDecoration("E-mail address", "Enter your email"),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter Your Email";
          }
          if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
            return "Enter a valid email address";
          }
          return null;
        },
        onSaved: (value) {
          _emailEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //mobile Number field

    final mobileNumberField = Container(
      child: TextFormField(
        controller: _mobileNumberEditingController,
        decoration: CustomTheme()
            .textInputDecoration("Mobile Number", "Enter your mobile number"),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter Mobile Number";
          }
          return null;
        },
        onSaved: (value) {
          _mobileNumberEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //password field
    final passwordField = Container(
      child: TextFormField(
        controller: _passwordEditingController,
        obscureText: true,
        decoration: CustomTheme()
            .textInputDecoration("Password*", "Enter your password"),
        validator: (val) {
          if (val!.isEmpty || val.length < 6) {
            return "Please enter at least 6 Character";
          }
          return null;
        },
        onSaved: (value) {
          _passwordEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //confirm password field
    final confirmPasswordField = Container(
      child: TextFormField(
        controller: _confirmPasswordEditingController,
        obscureText: true,
        decoration: CustomTheme()
            .textInputDecoration("Confirm Password*", "Enter your password"),
        validator: (val) {
          if (val!.isEmpty || val.length < 6) {
            return "Please enter at least 6 Character";
          }
          if (_confirmPasswordEditingController.text !=
              _passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          _confirmPasswordEditingController.text = value!;
        },
      ),
      decoration: CustomTheme().inputBoxDecorationShadow(),
    );

    //signup button
    final signUpButton = Container(
      decoration: CustomTheme().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: CustomTheme().buttonStyle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Text(
            "Register".toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          signUp(_emailEditingController.text, _passwordEditingController.text);
        },
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                  Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: const Text('Registration'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        firstNameField,
                        const SizedBox(height: 30),
                        secondNameField,
                        const SizedBox(height: 20.0),
                        emailField,
                        const SizedBox(height: 20.0),
                        mobileNumberField,
                        const SizedBox(height: 20.0),
                        passwordField,
                        const SizedBox(height: 20.0),
                        confirmPasswordField,
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: checkboxValue,
                                      onChanged: (value) {
                                        setState(
                                              () {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          },
                                        );
                                      },
                                    ),
                                    const Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        signUpButton,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling user model
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = _firstNameEditingController.text;
    userModel.secondName = _secondNameEditingController.text;
    userModel.mobileNumber = _mobileNumberEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successful.. ");
    Navigator.pushNamed(context, LoginScreen.id);
  }
}
