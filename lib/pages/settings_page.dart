import 'package:auth/pages/signin_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: SizedBox(
                          width: 170,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Wyloguj',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.logout,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
                          'Ustawienia',
                          style: TextStyle(
                            fontSize: 40.0,
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
                        //------Dane Osobowe------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Dane Osobowe',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Edytuj'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //------Powiadomienia------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Powiadomienia',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Edytuj'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //------Język------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Język',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Polski'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //------Kod PIN/Odcisk Palca------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Kod PIN/Odcisk Palca',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Edytuj'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: const Text(
                                'Dokumenty',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          ],
                        ),
                        //------Przetwarzanie Danych------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Przetwarzanie Danych',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Czytaj'),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //------Regulamin------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Regulamin',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Czytaj'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //------Usuń konto------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Usuń konto',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Nunito",
                                    ),
                                    primary: halfBlackColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Usuń'),
                                ),
                              ],
                            ),
                          ],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print("zastosuj");
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                ),
                child: const Text(
                  'Zastosuj',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
