import 'package:flutter/material.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Home'),
      drawer: CustomDrawer.customDrawer(context),
      body: const Center(
        child: Image(
          image: AssetImage('icons/reciept.png'),
        ),
      ),
    );
  }
}
