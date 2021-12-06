//Plugins
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//Theme
import 'package:auth/theme/text.dart';

class StatutePage extends StatefulWidget {
  const StatutePage({Key? key}) : super(key: key);

  @override
  _StatutePageState createState() => _StatutePageState();
}

class _StatutePageState extends State<StatutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  //------Pasek Górny------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Dokumenty',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //------Napis Ustawienia------
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Regulamin',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  //------Ustawienia------
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          '1. Niniejszy regulamin (dalej: Regulamin) określa zasady korzystania z aplikacji mobilnej "' +
                              appName +
                              '" (dalej: Aplikacja);',
                          style: documentsText,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '2. Właścicielem aplikacji jest drużyna "Różowe Jednorożce Patatające Po Łące W Szpileczkach Po Tęczy";',
                          style: documentsText,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '3. Dostawcą i Administratorem aplikacj jest drużyna "Różowe Jednorożce Patatające Po Łące W Szpileczkach Po Tęczy";',
                          style: documentsText,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '4. Użytkownikiem aplikacji jest każda osoba, która pobrała Aplikację;',
                          style: documentsText,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '5. Aplikacja służy do ;',
                          style: documentsText,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '6. Powyższy dokument jest tylko przykładowym dokumentem i twórcy aplikacji nie ponoszą żadnej odpowiedzialności za nie wywiązanie się z któregoś z powyższych punktów;',
                          style: documentsText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
