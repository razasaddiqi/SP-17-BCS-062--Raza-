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
            title: Text('Dice Game'),
            bottom: TabBar(
              tabs: [
                Tab(text: "Game"),
                Tab(text: "Contact Us"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child:
                      const Text('Simple Level', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 5,),
                  // SizedBox(height: 2,),
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child:
                      const Text('Hard Level', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],),
              ),


              // Text('Game Page (Later will be change)'),
              Text('Contact Page (Later will be change)'),
            ],
          ),
        ),
      ),
    );
  }
}