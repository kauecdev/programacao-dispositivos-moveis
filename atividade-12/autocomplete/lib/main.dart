import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: AutocompleteApp(),
      ),
    ),
  ));
}

class AutocompleteApp extends StatefulWidget {
  const AutocompleteApp({Key? key}) : super(key: key);

  @override
  State<AutocompleteApp> createState() => _AutocompleteAppState();
}

class _AutocompleteAppState extends State<AutocompleteApp> {

  List<String> cityNames = ["Stormwind", "Ironforge", "Gnomeregan", "Darnassus", "Exodar", "Gilneas"];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return cityNames;
        }
        return cityNames.map((e) => e.toLowerCase()).where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
         debugPrint('You just selected $selection');
      },
    );
  }
}
