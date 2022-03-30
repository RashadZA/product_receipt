import 'package:flutter/material.dart';

class CustomAppBar{
 static AppBar customAppBar(context, appBarTitle){
    return AppBar(
        title: Text(
          '$appBarTitle',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary,]
              )
          ),
        ),

    );
  }
}