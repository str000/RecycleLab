import 'package:auth/theme/colors.dart';
import 'package:auth/utils/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isSendingVerification = false;

  User? _currentUser = FirebaseAuth.instance.currentUser;

  provider() {
    if (_currentUser!.providerData[0].providerId == "google.com") {
      return "Google";
    } else {
      return "Email i Hasło";
    }
  }

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
                    ],
                  ),
                  //------Napis Ustawienia------
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Dane Konta',
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
                        Text(
                          'NAME: ${_currentUser!.displayName}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'EMAIL: ${_currentUser!.email}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          'Provider: ${provider()}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 16.0),
                        _currentUser!.emailVerified
                            ? Text(
                                'Email verified',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.green),
                              )
                            : Text(
                                'Email not verified',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.red),
                              ),
                        SizedBox(height: 16.0),
                        _isSendingVerification
                            ? CircularProgressIndicator()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isSendingVerification = true;
                                      });
                                      await _currentUser!
                                          .sendEmailVerification();
                                      setState(() {
                                        _isSendingVerification = false;
                                      });
                                    },
                                    child: Text('Verify email'),
                                  ),
                                  SizedBox(width: 8.0),
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: () async {
                                      User? user = await FireAuth.refreshUser(
                                          _currentUser!);

                                      if (user != null) {
                                        setState(() {
                                          _currentUser = user;
                                        });
                                      }
                                    },
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
