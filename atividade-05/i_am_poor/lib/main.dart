import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(
          child: Text("I am poor")
        )
      ),
      body: const Center(
        child: Image(
          image: AssetImage('images/coal.png'),
        )
      ),
      backgroundColor: Colors.green,
    )
  ));
}