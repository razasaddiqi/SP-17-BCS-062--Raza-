import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:math';
import 'dart:io';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  AnimationController _controller;
  CurvedAnimation animation;
  int count_left=0;
  int count_right=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    //_controller.forward();
    animation.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDice = Random().nextInt(6) + 1;
          count_left+=leftDice;
          rightDice = Random().nextInt(6) + 1;
          count_right+=rightDice;
        });
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }
  void check_winner() {
    var winner="";
    if (count_left>count_right){
      winner="Winner is Left Dice";
    }
    else if (count_left<count_right){
      winner="Winner is Right Dice";
    }
    else{
      winner="Match Draw";
    }
     showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Column(

         children: [
           Row(
             children: [
               Text("Left Dice Score:"),
               Text("${count_left}"),
             ],
           ),
           Row(
             children: [
               Text("Right Dice Score:"),
               Text("${count_right}"),
             ],
           ),
           Text("${winner}")
         ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Reset'),
            onPressed: () {Navigator.of(context).pop();
            count_left=0;
            count_right=0;
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Game'),
        backgroundColor: Colors.green[400],
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {exit(0);},
                child: Icon(
                  Icons.close,
                  size: 26.0,
                ),
              )
          ),

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(
                          height: 200 - (_controller.value * 200),
                          image: AssetImage(
                              'images/dice-png-$leftDice.png'),
                        )),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                      onDoubleTap: roll,
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Image(
                            height: 200 - ((animation.value) * 200),
                            image:
                            AssetImage('images/dice-png-$rightDice.png'),
                          )),
                    )),
              ],
            ),
            RaisedButton(
              onPressed: roll,
              child: Text(
                'ROLL',
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.lightGreen[300],
              splashColor: Colors.yellowAccent,

            ),
            RaisedButton(
              onPressed: check_winner,
              child: Text(
                'Check Winner',
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.lightGreen[300],
              splashColor: Colors.yellowAccent,

            ),
          ],
        ),
      ),
    );
  }
}
