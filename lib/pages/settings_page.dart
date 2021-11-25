//Plugins
import 'package:auth/widgets/settings_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import 'package:auth/pages/settings/account_page.dart';
import 'package:auth/pages/settings/delete_account_page.dart';
import 'package:auth/pages/settings/notification_page.dart';
import 'package:auth/pages/signin_page.dart';
import 'documents/data_processing.dart';
import 'documents/statute.dart';
//Utils

//Theme
import 'package:auth/theme/colors.dart';
//Widgets

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
                        SettingsWidgets.settingOption(
                          optionText: "Dane Konta",
                          optionAction: "Edytuj",
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AccountPage(),
                              ),
                            );
                          },
                          context: context,
                        ),
                        //------Powiadomienia------
                        SettingsWidgets.settingOption(
                          optionText: "Powiadomienia",
                          optionAction: "Edytuj",
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NotificationPage(),
                              ),
                            );
                          },
                          context: context,
                        ),
                        //------Język------
                        SettingsWidgets.settingOption(
                          optionText: "Język",
                          optionAction: "Polski",
                          onPress: () {},
                          context: context,
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
                        SettingsWidgets.settingOption(
                          optionText: "Przetwarzanie Danych",
                          optionAction: "Czytaj",
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DataProcessingPage(),
                              ),
                            );
                          },
                          context: context,
                        ),
                        //------Regulamin------
                        SettingsWidgets.settingOption(
                          optionText: "Regulamin",
                          optionAction: "Czytaj",
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const StatutePage(),
                              ),
                            );
                          },
                          context: context,
                        ),
                        //------Usuń konto------
                        SettingsWidgets.settingOption(
                          optionText: "Usuń Konto",
                          optionAction: "Usuń",
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DeleteAccountPage(),
                              ),
                            );
                          },
                          context: context,
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
