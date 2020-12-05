import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:math';

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
                      que_count+=1;
                      // selected_answers.add(value);
                      // print()
                      // count+=1;
                    });
                    if(que_count==5){
                      check_winner();
                    }
                  },
                ),
              )

          )
        // new Container(
        //     padding: EdgeInsets.symmetric(horizontal: 25),
        //     decoration: BoxDecoration(
        //       // shape:  BoxShape.circle,
        //       borderRadius: BorderRadius.circular(80.0),
        //     ),
        //     width: double.infinity,
        //     height: 80,
        //     child:FlatButton(
        //       color: Color(0xFF00E676),
        //       textColor: Colors.white,
        //       child: new Text(options[q-1],style: TextStyle(fontSize: 25),),
        //       onPressed: () {
        //         checkAnswer(q,context);
        //       },
        //     )
        // )

      );
    }
    return temp;
  }
  void hideWidget() {
    setState(() {
      can_show_image = !can_show_image;
    });
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
            que_count=0;
            // setState(() {
            //   can_show_image=!can_show_image;
            // });
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
            RaisedButton(
              onPressed: roll,
              child: Text(
                'ROLL',
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
