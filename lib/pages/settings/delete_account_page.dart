import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/utils/validator.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusDate = FocusNode();
  final _focusEmail = FocusNode();

  User? _currentUser = FirebaseAuth.instance.currentUser;

  bool _isgoogle = false;
  bool isChecked = false;

  DateTime? _chosenDate;
  bool _dateChosen = false;

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 245,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime:
                            _dateChosen ? _chosenDate : DateTime.now(),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDate = val;
                            _dateChosen = true;
                          });
                          _dateTextController.text =
                              DateFormat('dd/MM/yyyy').format(val).toString();
                        }),
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Potwierdź',
                      style: signTextFormField,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  void initState() {
    _nameTextController.text = _currentUser!.displayName!;
    _emailTextController.text = _currentUser!.email!;
    if (_currentUser!.providerData[0].providerId == "google.com") {
      _isgoogle = true;
    }
    super.initState();
  }

  Future<void> refresh() async {
    User? user = await FireAuth.refreshUser(_currentUser!);

    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusDate.unfocus();
        _focusEmail.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
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
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 100,
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
                        onPressed: isChecked ? () {} : null,
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
      ),
    );
  }
}
