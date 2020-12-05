import 'package:flutter/material.dart';

void main() {
  runApp(home_screen());
}

class home_screen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan, // status bar color
            brightness: Brightness.light,
            title: Text('Flutter App'),
            bottom: TabBar(
              tabs: [
                Tab(text: "Game"),
                Tab(text: "Contact Us"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Text('Game Page (Later will be change)'),
              Text('Contact Page (Later will be change)'),
            ],
          ),
        ),
      ),
    );
  }
}