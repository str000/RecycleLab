//Plugins
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import '../signin_page.dart';
//Theme
import 'package:auth/theme/colors.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                          'Ustawienia',
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
                          'Usuń Konto',
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
                      children: const [
                        Text(
                          '1. Usunięcie konta spowoduje trwałe i nieodwracalne usunięcie wszystkich danych związanych z kontem.',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '2. Naciskając poniższy przycisk oświadczasz że zapoznałeś/aś się z powyższym punktem i jest on całkowicie zrozumiały.',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '3. Aby uzyskać więcej informacji na temat usuwania konta przejdź do regulaminu',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
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
        child: SizedBox(
          height: 120,
          child: Column(
            children: [
              Row(children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text(
                  'Zapoznałem/am się z powyższym',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isChecked
                          ? () {
                              final ref = FirebaseDatabase.instance.reference();

                              ref.child('users/' + _currentUser!.uid).remove();

                              _currentUser!
                                  .delete()
                                  .then((value) => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      ));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'Usuń Konto',
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
            ],
          ),
        ),
      ),
    );
  }
}
