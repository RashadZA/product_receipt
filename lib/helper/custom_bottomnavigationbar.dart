import 'package:flutter/material.dart';

class CustomBottomNavigationBar{
  
  BottomNavigationBar customBottomNavigationBar(){
    int _selectedIndex = 0;
    TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
      ),
      Text(
        'Index 1: Business',
      ),
      Text(
        'Index 2: School',
      ),
    ];

    void _onItemTapped(int index) {
      // setState(() {
      //   _selectedIndex = index;
      // });
    }
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}