import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String id = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo()  {

      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
      });
    print(loggedInUser.firstName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Profile'),
      drawer: CustomDrawer.customDrawer(context),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey.shade300,
                ),
                SizedBox(width: 10),
                Text('${loggedInUser.firstName}' ' ${loggedInUser.secondName}'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  color: Colors.grey.shade300,
                ),
                SizedBox(width: 10),
                Text('${loggedInUser.mobileNumber}'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey.shade300,
                ),
                SizedBox(width: 10),
                Text('${loggedInUser.email}'),
              ],
            ),
            const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(Icons.person,
            //       color: Colors.grey.shade300,),
            //     SizedBox(width: 10),
            //     Text('Name')
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
