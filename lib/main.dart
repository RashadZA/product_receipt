import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:product_receipt/screen/customer/add_customer_screen.dart';
import 'package:product_receipt/screen/customer/customer_screen.dart';
import 'package:product_receipt/screen/expense/expense_screen.dart';
import 'package:product_receipt/screen/home_screen.dart';
import 'package:product_receipt/screen/invoice/add_invoice_screen.dart';
import 'package:product_receipt/screen/invoice/invoice_screen.dart';
import 'package:product_receipt/screen/invoice/sample_invoice_screen.dart';
import 'package:product_receipt/screen/item/add_Item_screen.dart';
import 'package:product_receipt/screen/item/item_screen.dart';
import 'package:product_receipt/screen/login_screen.dart';
import 'package:product_receipt/screen/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Color _primaryColor = HexColor('#266C09');
  final Color _accentColor = HexColor('#C3EAB3');
  final Color _splashColor = HexColor('#CBD4C7');
  final Color _focusColor = HexColor('#46643A');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: _primaryColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: _accentColor),
          splashColor: _splashColor,
          focusColor: _focusColor
      ),
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        AddCustomerScreen.id: (context) => const AddCustomerScreen(),
        CustomerScreen.id: (context) => const CustomerScreen(),
        AddItemScreen.id: (context) => const AddItemScreen(),
        ItemScreen.id: (context) => const ItemScreen(),
        AddInvoiceScreen.id: (context) => const AddInvoiceScreen(),
        InvoiceScreen.id: (context) => const InvoiceScreen(),
        ExpenseScreen.id: (context) =>  const ExpenseScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        SampleInvoiceScreen.id: (context) => const SampleInvoiceScreen()
      },
      home: const LoginScreen(),
    );
  }

}