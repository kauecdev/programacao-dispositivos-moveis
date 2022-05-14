import 'package:flutter/material.dart';
import 'package:privacy_policies/privacy_policies_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: PrivacyPoliciesApp(),
        ),
      ),
    )
  );
}

class PrivacyPoliciesApp extends StatefulWidget {
  const PrivacyPoliciesApp({Key? key}) : super(key: key);

  @override
  State<PrivacyPoliciesApp> createState() => _PrivacyPoliciesAppState();
}

class _PrivacyPoliciesAppState extends State<PrivacyPoliciesApp> {

  bool firstCheckboxValue = false;
  bool secondCheckboxValue = false;
  bool thirdCheckboxValue = false;
  bool? acceptAllCheckboxValue = false;

  check() {
    setState(() {
      if (firstCheckboxValue && secondCheckboxValue && thirdCheckboxValue) {
        acceptAllCheckboxValue = true;
      } else if (firstCheckboxValue || secondCheckboxValue || thirdCheckboxValue) {
        acceptAllCheckboxValue = null;
      } else {
        acceptAllCheckboxValue = false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2)
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: privacyPolicies,
                  ),
                )
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    title: Text("Eu aceito as políticas de privacidade."),
                    value: firstCheckboxValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        firstCheckboxValue = newValue!;
                      });
                      check();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text("Eu aceito receber e-mails com novidades e ofertas exclusivas."),
                    value: secondCheckboxValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        secondCheckboxValue = newValue!;
                      });
                      check();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text("Eu aceito compartilhar minhas informações."),
                    value: thirdCheckboxValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        thirdCheckboxValue = newValue!;
                      });
                      check();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text("Aceitar todos os itens acima."),
                    value: acceptAllCheckboxValue,
                    onChanged: (bool? newValue) {
                      newValue = newValue ?? false;
                      setState(() {
                        acceptAllCheckboxValue = newValue!;
                        firstCheckboxValue = newValue;
                        secondCheckboxValue = newValue;
                        thirdCheckboxValue = newValue;
                      });
                    },
                    tristate: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

CheckboxListTile buildCheckboxListTile(
    {required String text,
    required bool value,
    required void Function(bool?)? onChange,
    bool? isTristate}) {
  return CheckboxListTile(
    title: Text(text),
    value: value,
    onChanged: onChange,
    tristate: isTristate ?? true,
    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
  );
}