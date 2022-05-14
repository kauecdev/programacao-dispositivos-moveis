import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      const MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<bool> _selections = List.generate(3, (_) => false);
  bool boldActive = false;
  bool italicActive = false;
  bool underlineActive = false;

  String text = "Formate este texto.";

  onOptionPlay(int index) {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
        if (buttonIndex == index) {
          _selections[buttonIndex] = !_selections[buttonIndex];
        }

        if (index == 0) {
          boldActive = !boldActive;
        }

        if (index == 1) {
          italicActive = !italicActive;
        }

        if (index == 2) {
          underlineActive = !underlineActive;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(text, style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Roboto",
                      fontStyle: italicActive ? FontStyle.italic : FontStyle.normal,
                      fontWeight: boldActive ? FontWeight.bold : FontWeight.normal,
                      decoration: underlineActive ? TextDecoration.underline : TextDecoration.none
                    ),
                  ),
                  const SizedBox(height: 80,),
                  ToggleButtons(
                    children: const <Widget>[
                      Icon(Icons.format_bold, size: 30,),
                      Icon(Icons.format_italic, size: 30,),
                      Icon(Icons.format_underline, size: 30,),
                    ],
                    isSelected: _selections,
                    onPressed: (int index) {
                      onOptionPlay(index);
                    },
                  ),
                ],
              )
          ),
        )
    );
  }
}
