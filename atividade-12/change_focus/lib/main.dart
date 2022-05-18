import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
      const MaterialApp(
        home: ChangeFocusApp(),
      )
  );
}

class ChangeFocusApp extends StatefulWidget {
  const ChangeFocusApp({Key? key}) : super(key: key);

  @override
  State<ChangeFocusApp> createState() => _ChangeFocusAppState();
}

class _ChangeFocusAppState extends State<ChangeFocusApp> {

  late FocusNode firstFieldFocusNode;
  late FocusNode secondFieldFocusNode;
  late FocusNode thirdFieldFocusNode;

  @override
  void initState() {
    firstFieldFocusNode = FocusNode();
    secondFieldFocusNode = FocusNode();
    thirdFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    firstFieldFocusNode.dispose();
    secondFieldFocusNode.dispose();
    thirdFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RawKeyboardListener(
            onKey: (event) {
              if (event is RawKeyDownEvent && event.isKeyPressed(LogicalKeyboardKey.enter)) {
                if (firstFieldFocusNode.hasFocus) {
                  firstFieldFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(secondFieldFocusNode);
                } else if (secondFieldFocusNode.hasFocus) {
                  secondFieldFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(thirdFieldFocusNode);
                }
              }
            },
            autofocus: true,
            focusNode: FocusNode(),
            child: Column(
              children: <Widget>[
                buildTextFormField("Name", firstFieldFocusNode),
                buildTextFormField("E-mail", secondFieldFocusNode),
                buildTextFormField("Password", thirdFieldFocusNode),
              ]
            ),
          )
        ),
      ),
    );
  }
}

TextField buildTextFormField(String label, FocusNode focusNode) {
  return TextField(
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: label,
    ),
  );
}