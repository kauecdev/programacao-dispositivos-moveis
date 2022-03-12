import 'package:flutter/material.dart';

void main() {
  runApp(MyDigitalBusinessCard());
}

class MyDigitalBusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF7B1FA6),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image(
                                  image: AssetImage("images/software-developer-icon.png"),
                                ),
                                SizedBox(height: 25,),
                                buildCustomText("Kauê Cavalcante", Color(0xFFF4F4F4), 30, FontWeight.w600),
                                buildCustomText("Software Developer", Color(0xFFF4F4F4), 18, FontWeight.w600),
                                SizedBox(height: 25),
                                buildCustomText("Fullstack Developer", Color(0xFFF4F4F4), 16, FontWeight.w400),
                                buildCustomText("CyberOne Security", Color(0xFFF4F4F4), 16, FontWeight.w400),
                                SizedBox(height: 120),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    buildCustomText("Sobre mim", Color(0xFF030303), 24, FontWeight.w600),
                                    buildCustomText(
                                        "Sou apaixonado por tecnologia em todas as suas formas, com foco principal no desenvolvimento de software. Estou sempre disposto a entregar código com a melhor qualidade de leitura para o time e melhor funcionalidade para o usuário."
                                        , Color(0xFF030303), 14, FontWeight.w300, textAlign: TextAlign.justify)
                                  ],
                                ),
                                SizedBox(height: 20),
                                buildCustomListTile(Icons.business, "CyberOne Security"),
                                buildCustomListTile(Icons.mail, "kaue_cavalcante.cnt@outlook.com"),
                                buildCustomListTile(Icons.phone, "(86) 98141 0641")
                              ]
                          ),
                        ),
                        Positioned(
                          top: 170,
                          right: -10,
                          child: Image(
                              image: AssetImage("images/me.png")
                          ),
                        ),
                      ],
                    )
                ),
              ),
            )
        )
    );
  }

  Text buildCustomText(String text, Color color, double fontSize, FontWeight fontWeight, { TextAlign textAlign }) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
      ),
      textAlign: textAlign,
    );
  }

  Container buildCustomListTile(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.all(6),
      child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF7B1FA6)
              ),
              child: Icon(
                icon,
                color: Color(0xFFF4F4F4),
              ),
            ),
            SizedBox(width: 10),
            Text(
                text,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF030303)
                )
            )
          ]
      ),
    );
  }
}
