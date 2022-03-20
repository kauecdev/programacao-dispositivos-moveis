import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMiniGamePage(title: 'Mini Game'),
    );
  }
}

class MyMiniGamePage extends StatefulWidget {
  const MyMiniGamePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyMiniGamePage> createState() => _MyMiniGamePageState();
}

class _MyMiniGamePageState extends State<MyMiniGamePage> {

  List<int> spaces = List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: [for(int i = 0; i < 9; i++) Container(
                  color: const Color(0xFFF1F1F1),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        spaces[i] = 1;
                        AiPlay();
                      });
                    },
                    child: Center(
                      child: Icon(
                          spaces[i] == 0
                              ? null
                              : (spaces[i] == 1
                                  ? Icons.close
                                  : Icons.circle_rounded
                                )
                      )
                    )
                  )
                )],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  isWinning(1, spaces)
                    ? "Você ganhou!"
                    : isWinning(2, spaces)
                      ? "Você perdeu!"
                      : !spaces.contains(0)
                        ? "Deu velha!"
                        : "Sua vez"
                  ,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      spaces = List.filled(9, 0);
                    });
                  },
                  child: const Text(
                    "Reiniciar",
                    style: TextStyle(
                      fontSize: 20,
                    )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void AiPlay() async {
    await Future.delayed(const Duration(milliseconds: 200));

    int? winning;
    int? blocking;
    int? normal;

    for (int i = 0; i < 9; i++) {
      int value = spaces[i];

      if (value > 0) {
        continue;
      }

      List<int> futureSpaces = [...spaces]..[i] = 2;

      if (isWinning(2, futureSpaces)) {
        winning = i;
      }

      futureSpaces[i] = 1;

      if (isWinning(1, futureSpaces)) {
        blocking = i;
      }

      normal = i;
    }

    int? move = winning ?? blocking ?? normal;

    if (move != null) {
      setState(() {
        spaces[move] = 2;
      });
    }
  }

  bool isWinning(int player, List<int> spaces) {
    List<bool> winCases = [
      spaces[0] == player && spaces[1] == player && spaces[2] == player,
      spaces[3] == player && spaces[4] == player && spaces[5] == player,
      spaces[6] == player && spaces[7] == player && spaces[8] == player,
      spaces[0] == player && spaces[4] == player && spaces[8] == player,
      spaces[2] == player && spaces[4] == player && spaces[6] == player,
      spaces[0] == player && spaces[3] == player && spaces[6] == player,
      spaces[1] == player && spaces[4] == player && spaces[7] == player,
      spaces[2] == player && spaces[5] == player && spaces[8] == player,
    ];

    return winCases.contains(true) ? true : false;
  }
}
