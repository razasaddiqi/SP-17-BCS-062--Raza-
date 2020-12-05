import 'package:flutter/material.dart';
import 'simple_level.dart';
import 'hard_level.dart';
import 'package:contactus/contactus.dart';
void main() {
  runApp(home_screen());
}

class home_screen extends StatelessWidget {
  static Widget circularImageWithBorder(String imgPath, double rad, double borderWidth, Color borderColor) {
    return CircleAvatar(
        radius: rad + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          backgroundImage: AssetImage(imgPath),
          radius: rad,
        ));
  }
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => hard_level()),
                      );
                    },
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
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    child: Card(
                        color: Color(0xffeeeeee),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 40, bottom: 0, left: 10, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Text("Raza Fayyaz Saddiqi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("I am the student of computer science final semester.", style: TextStyle()),
                                  Text("Expertise:", style: TextStyle()),
                                  Row(

                                    children: [
                                    Text("Artificial Intelligence", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 4,),
                                    Text("Web Development", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],),
                                  Row(children: [
                                    Text("Mobile app development", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 4,),
                                    Text("Web Scrapping", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  circularImageWithBorder(
                      "images/my_pic.jpg", 30, 2, Colors.black),
                ],
              ),
              // Text('Contact Page (Later will be change)'),
            ],
          ),
        ),
      ),
    );
  }
}