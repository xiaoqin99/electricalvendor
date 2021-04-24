import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        backgroundColor: Colors.pinkAccent[400],
      ),
      backgroundColor: Colors.teal[50],
      body: Center(
           child: Container(
              child: Text('Welcome',
                  style: TextStyle(color: Colors.black54, fontSize: 22)),
            ),
        ),
    );
  }
}
