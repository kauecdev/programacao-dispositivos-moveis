import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lotr_wiki/character.dart';
import 'package:http/http.dart' as http;

class CharacterDetailPage extends StatefulWidget {

  static const routeName = '/character';

  final String characterId;

  const CharacterDetailPage({Key? key, required this.characterId}) : super(key: key);

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPage();

}

class _CharacterDetailPage extends State<CharacterDetailPage> {

  late Character character;

  Future<http.Response> getCharacter() async {
    String? token = dotenv.env['TOKEN'];

    final response = await http
        .get(
        Uri.parse('https://the-one-api.dev/v2/character/${widget.characterId}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    return response;
  }

  @override
  void initState() {
    getCharacter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Character Details"),
        ),
        body: SafeArea(
          child: FutureBuilder<http.Response>(
              future: getCharacter(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Character characterLoaded = Character.fromJson(jsonDecode(snapshot.data!.body)['docs'][0]);
                  return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          buildTextInfo("Name", characterLoaded.name),
                          buildTextInfo("Race", characterLoaded.race),
                          buildTextInfo("Gender", characterLoaded.gender),
                          buildTextInfo("Realm", characterLoaded.realm),
                          buildTextInfo("Birth", characterLoaded.birth),
                          buildTextInfo("Death", characterLoaded.death),
                          buildTextInfo("Wiki URL", characterLoaded.wikiUrl),
                        ],
                      )
                  );
                }

                return const Center(
                 child: CircularProgressIndicator()
                );
              }
          )
        )
    );
  }
}

Row buildTextInfo(String title, String text) {
  return Row(
    children: <Widget>[
      Text(
        '${title}: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      Text(
        text,
      ),
    ],
  );
}