import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ImageZoomApp()
        )
      ),
    )
  );
}

class ImageZoomApp extends StatefulWidget {
  const ImageZoomApp({Key? key}) : super(key: key);

  @override
  State<ImageZoomApp> createState() => _ImageZoomAppState();
}

class _ImageZoomAppState extends State<ImageZoomApp> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: Transform.scale(
              scale: _currentSliderValue == 1 ? 1 : _currentSliderValue / 10,
              child: Image.asset('assets/potion.jpg', height: 400,),
            ),
          ),
          Slider(
              value: _currentSliderValue,
              max: 100,
              min: 1,
              divisions: 10,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
          )
        ]
      ),
    );
  }
}
