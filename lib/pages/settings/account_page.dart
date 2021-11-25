import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/utils/validator.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: _isgoogle
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4),
                                                      topRight:
                                                          Radius.circular(4),
                                                      bottomLeft:
                                                          Radius.circular(4),
                                                      bottomRight:
                                                          Radius.circular(4),
                                                    ),
                                                    border: Border.all(
                                                        color:
                                                            quarterBlackcolor),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 12.0,
                                                      bottom: 12.0,
                                                      left: 20.0,
                                                      right: 20.0,
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      children: [
                                                        const Image(
                                                            width: 26.0,
                                                            height: 26.0,
                                                            image: AssetImage(
                                                                'assets/google_logo.png')),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'Konto Google',
                                                              style: TextStyle(
                                                                color:
                                                                    halfBlackColor,
                                                                fontSize: 20.0,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : null,
                                  ),
                                  Container(
                                    child: _isgoogle
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, bottom: 13.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              child: Image.network(_currentUser!
                                                  .photoURL
                                                  .toString()),
                                            ),
                                          )
                                        : null,
                                  ),
                                  TextFormField(
                                    controller: _nameTextController,
                                    focusNode: _focusName,
                                    validator: (value) =>
                                        Validator.validateName(
                                      name: value,
                                    ),
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Nazwa",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                    },
                                  ),
                                  const SizedBox(height: 13.0),
                                  //TODO Dodać datę urodzenia do bazy używając UID
                                  Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        TextFormField(
                                          controller: _dateTextController,
                                          focusNode: _focusDate,
                                          validator: (value) {
                                            Validator.validateDate(
                                              date: value,
                                            );
                                          },
                                          enabled: false,
                                          style: signTextFormField,
                                          decoration:
                                              CommonStyle.textFieldStyle(
                                            labelTextStr: "Data Urodzenia",
                                          ),
                                          onChanged: (String? value) {
                                            _formKey.currentState!.validate();
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _showDatePicker(context);
                                          },
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          color: halfBlackColor,
                                        ),
                                      ]),
                                  const SizedBox(height: 13.0),
                                  TextFormField(
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    enabled: _isgoogle ? false : true,
                                    validator: (value) =>
                                        Validator.validateEmail(
                                      email: value,
                                    ),
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Adres Email",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                    },
                                  ),
                                  const SizedBox(height: 5.0),

                                  _currentUser!.emailVerified
                                      ? const Text(
                                          'Email Zweryfikowany',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  _scaffoldKey.currentState!
                                                      // ignore: deprecated_member_use
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      elevation: 6.0,
                                                      backgroundColor:
                                                          primaryColor,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      content: Text(
                                                        'Sprawdź swoją pocztę, następnie odśwież tą stronę',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Nunito',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                  await _currentUser!
                                                      .sendEmailVerification();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: primaryColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5.0,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Zweryfikuj Email',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: null,
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
      ),
    );
  }
}
