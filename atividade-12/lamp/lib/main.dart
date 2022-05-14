import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: LampApp()
        )
      )
    )
  );
}

class LampApp extends StatefulWidget {
  const LampApp({Key? key}) : super(key: key);

  @override
  State<LampApp> createState() => _LampAppState();
}

class _LampAppState extends State<LampApp> {
  bool isLampOn = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(
              isLampOn ? "assets/lamp_on.png" : "assets/lamp_off.png"
            ),
          ),
          const SizedBox(height: 40),
          Transform.scale(
            scale: 2,
            child: Switch.adaptive(value: isLampOn, onChanged: (value) {
              setState(() {
                isLampOn = value;
              });
            }),
          ),
          const SizedBox(height: 20,),
          const Text(
            "Acender/Apagar",
            style: TextStyle(
              fontSize: 24
            ),
          )
        ],
      ),
    );
  }
}
