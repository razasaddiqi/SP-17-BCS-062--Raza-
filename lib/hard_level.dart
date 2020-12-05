import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:math';
import 'dart:io';
class hard_level extends StatefulWidget {
  @override
  _hardScreenState createState() => _hardScreenState();
}

class _hardScreenState extends State<hard_level>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  AnimationController _controller;
  CurvedAnimation animation;
  int que_count=0;
  int count_left=0;
  int count_right=0;
  bool can_show_image=true;
  int correct_index=-1;
  int correct_ans=0;
  int wrong_ans=0;
  bool can_show_button=true;
  List<Widget> _getList(int correct_num) {
    List list = List.generate(6, (i) => i+1);
    list.shuffle();
    list.remove(correct_num);
    // print(list);
    List<int> options= [correct_num,list[0],list[1],list[2]];
    options..shuffle();
    // print(options.length);
    List<Widget> temp = [];
    int _value=-1;
    List<int> correct_answers=[];
    List<int> selected_answers=[];
    for (var q = 0; q<options.length; q++) {
      if (options[q]==correct_num){
        correct_index=q;
        correct_answers.add(q);
      }
      temp.add(
          ListTile(
              title:  Text(options[q].toString(),style: TextStyle(fontSize: 22,color: Colors.black),),
              leading: Transform.scale(
                scale: 2.0,
                child:    Radio(
                  hoverColor: Colors.indigo,
                  value: q,
                  groupValue: _value,
                  onChanged: (int value) {
                    if (correct_index==value){
                      correct_ans+=1;
                    }
                    else{
                      wrong_ans+=1;
                    }
                    // checkAnswer(q,context);

                    setState(() {
                      _value = value;
                      can_show_image=!can_show_image;
                      can_show_button=!can_show_button;
                      que_count+=1;
                    });
                    if(que_count==5){
                      check_winner();
                    }
                  },
                ),
              )
          )


      );
    }
    return temp;
  }

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
        // que_count+=1;
        // if(que_count<=5){
        setState(() {

          can_show_image = !can_show_image;
          can_show_button=!can_show_button;
          leftDice = Random().nextInt(6) + 1;
          print(leftDice);
          count_left+=leftDice;

          rightDice = Random().nextInt(6) + 1;
          count_right+=rightDice;
        });
        // }

        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();

  }
  void check_winner() {
    var winner="";
    if (correct_ans==3){
      winner="You Win";
    }
    else{
      winner="You lose";
    }
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Column(
          children: [
            Row(
              children: [
                Text("Correct Ans:"),
                Text("${correct_ans}"),
              ],
            ),
            Row(
              children: [
                Text("Wrong Ans"),
                Text("${wrong_ans}"),
              ],
            ),
            Text("${winner}")
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Reset'),
            onPressed: () {Navigator.of(context).pop();
            wrong_ans=0;
            correct_ans=0;
            setState(() {
              que_count=0;
            });

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
                        child:
                        can_show_image
                            ?Image(
                          height: 200 - (_controller.value * 200),
                          image: AssetImage(
                              'images/dice-png-$leftDice.png'),
                        )
                            : Column(children: _getList(leftDice),)
                    ),
                  ),
                )
              ],
            ),
            can_show_button?
            RaisedButton(
              onPressed: roll,
              child: Text(
                'ROLL',
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.lightGreen[300],
              splashColor: Colors.yellowAccent,

            ):Text("Take a guess",style: TextStyle(fontSize: 30),),

          ],
        ),
      ),
    );
  }
}
