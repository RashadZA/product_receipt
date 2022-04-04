import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar customAppBar(context, appBarTitle) {
    return AppBar(
      title: Text(
        '$appBarTitle',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: appBarBoxDecoration(context),
      ),
    );
  }

  static BoxDecoration appBarBoxDecoration(context) => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ]));
}
