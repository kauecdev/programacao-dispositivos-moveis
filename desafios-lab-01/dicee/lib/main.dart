import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("Dicee"),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      )
    )
  );
}

class DicePage extends StatefulWidget {

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  late int leftDiceNumber;
  late int rightDiceNumber;

  @override
  void initState() {
    leftDiceNumber = getRandomNumber();
    rightDiceNumber = getRandomNumber();

    while (leftDiceNumber == rightDiceNumber) {
      rightDiceNumber = getRandomNumber();
    }

    super.initState();
  }

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = getRandomNumber();
      rightDiceNumber = getRandomNumber();

      while (leftDiceNumber == rightDiceNumber) {
        rightDiceNumber = getRandomNumber();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              child: Image.asset('images/dice$leftDiceNumber.png'),
              onPressed: () {
                changeDiceFace();
              }
            ),
          ),
          Expanded(
            child: TextButton(
                child: Image.asset('images/dice$rightDiceNumber.png'),
                onPressed: () {
                  changeDiceFace();
                }
            ),
          )
        ],
      ),
    );
  }

  int getRandomNumber() {
    return Random().nextInt(8) + 1;
  }
}