//Plugins
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _notificationOneValue = false;
  bool _notificationTwoValue = false;
  bool _notificationThreeValue = false;
  bool _notificationFourValue = false;

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
                          'Powiadomienia',
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
                        //Powiadomienia 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Powiadomienia 1',
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
                                CupertinoSwitch(
                                  value: _notificationOneValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationOneValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0),

                        //Powiadomienia 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Powiadomienia 2',
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
                                CupertinoSwitch(
                                  value: _notificationTwoValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationTwoValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0),

                        //Powiadomienia 3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Powiadomienia 3',
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
                                CupertinoSwitch(
                                  value: _notificationThreeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationThreeValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0),

                        //Powiadomienia 4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Powiadomienia 4',
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
                                CupertinoSwitch(
                                  value: _notificationFourValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationFourValue = value;
                                    });
                                  },
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
    );
  }
}
