import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lotr_wiki/character.dart';
import 'package:http/http.dart' as http;
import 'package:lotr_wiki/character_detail_page.dart';
import 'package:lotr_wiki/page_arguments.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotr Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CharacterDetailPage.routeName) {
          final args = settings.arguments as PageArguments;

          return MaterialPageRoute(
            builder: (context) {
              return CharacterDetailPage(
                characterId: args.characterId,
              );
            },
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<Character> characterList = [];

  Future<void> getCharacters() async {

    String? token = dotenv.env['TOKEN'];

    final response = await http
        .get(
        Uri.parse('https://the-one-api.dev/v2/character?limit=100'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode != 200) {
      throw Exception('Failed to load characters');
    }

    List characterListJson = jsonDecode(response.body)['docs'] as List;

    List<Character> charactersLoaded = characterListJson.map((characterJson) => Character.fromJson(characterJson)).toList();

    setState(() {
      characterList = charactersLoaded;
    });

  }

  @override
  void initState() {
    getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          if (characterList.isNotEmpty) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  String? name = characterList[index].name;
                  String? id = characterList[index].id;
                  return Card(
                      elevation: 4,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                CharacterDetailPage.routeName,
                                arguments: PageArguments(id)
                            );
                          } ,
                          child: Text(
                            name,
                          )
                      )
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 10);
                },
                itemCount: characterList.length);
          } else {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
        }),
      )
    );
  }
}
