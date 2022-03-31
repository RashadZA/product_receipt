import 'package:flutter/material.dart';
import 'package:product_receipt/screen/customer/customer_screen.dart';
import 'package:product_receipt/screen/invoice/invoice_screen.dart';
import 'package:product_receipt/screen/item/item_screen.dart';
import 'package:product_receipt/screen/login_screen.dart';
import 'package:product_receipt/screen/profile_screen.dart';

class CustomDrawer {
  static Drawer customDrawer(context) {
    double _drawerIconSize = 24;
    double _drawerFontSize = 17;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.0,
              1.0
            ],
                colors: [
              Theme.of(context).primaryColor.withOpacity(0.2),
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ])),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "Product Receipt",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //Customer Option
            ListTile(
              leading: Icon(
                Icons.person,
                size: _drawerIconSize,
                color: Colors.blueGrey,
              ),
              title: const Text(
                'Customer',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.blueGrey),
              ),
              onTap: () {
                Navigator.pushNamed(context, CustomerScreen.id);
              },
            ),

            //Item Option
            ListTile(
              leading: Icon(Icons.post_add,
                  size: _drawerIconSize,
                  color: Colors.blueGrey),
              title: Text(
                'Item',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.blueGrey),
              ),
              onTap: () {
                Navigator.pushNamed(context, ItemScreen.id);
              },
            ),

            //Invoice Option
            ListTile(
              leading: Icon(Icons.production_quantity_limits,
                  size: _drawerIconSize,
                  color: Colors.blueGrey),
              title: Text(
                'Invoice',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.blueGrey),
              ),
              onTap: () {
                Navigator.pushNamed(context, InvoiceScreen.id);
              },
            ),

            //Profile Option
            ListTile(
              leading: Icon(
                Icons.person,
                size: _drawerIconSize,
                color: Colors.blueGrey,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.blueGrey),
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),

            //logout option
            ListTile(
              leading: Icon(
                Icons.logout_sharp,
                size: _drawerIconSize,
                color: Colors.blueGrey,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.blueGrey),
              ),
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
