import 'dart:convert';

import 'package:filter_from_api/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: FilterFromAPI(),
      ),
    ),
  ));
}

class FilterFromAPI extends StatefulWidget {
  const FilterFromAPI({Key? key}) : super(key: key);

  @override
  State<FilterFromAPI> createState() => _FilterFromAPIState();
}

class _FilterFromAPIState extends State<FilterFromAPI> {
  late List<Character> characterList = [];
  String dropdownValue = 'Human';

  Future<void> getCharacters() async {

    setState(() {
      characterList = [];
    });

    String? token = dotenv.env['TOKEN'];

    final response = await http
        .get(
        Uri.parse('https://the-one-api.dev/v2/character?race=$dropdownValue&limit=20'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode != 200) {
      throw Exception('Failed to load characters');
    }

    List characterListJson = jsonDecode(response.body)['docs'] as List;

    List<Character> charactersLoaded = characterListJson.map((character) => Character.fromJson(character)).toList();

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
    return Container(
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            items: <String>['Human', 'Elf', 'Dwarf', 'Hobbit', 'Maiar']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
              getCharacters();
            },
          ),
          Expanded(
            child:  LayoutBuilder(builder: (context, constraints) {
              if (characterList.isNotEmpty) {
                return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Character character = characterList[index];
                      return TextButton(
                          onPressed: () {} ,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                title: Text(
                                  character.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                tileColor: Colors.grey[800],
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              )
                          )
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 0);
                    },
                    itemCount: characterList.length);
              } else {
                return const Center(
                    child: CircularProgressIndicator()
                );
              }
            }),
          )
        ]
      ),
    );
  }
}
