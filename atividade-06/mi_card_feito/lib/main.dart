import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black26,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/eu.jpg'),
              ),
              Text(
                'Kauê Cavalcante',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'SOFTWARE DEVELOPER',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              buildCard('+55 86 98141 641', Icons.phone),
              buildCard('kaue_cavalcante.cnt@outlook.com', Icons.email),
            ],
          ),
        ),
      ),
    ),
  );
}

Card buildCard(String text, IconData icon) {
  return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black87,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
      ));
}
