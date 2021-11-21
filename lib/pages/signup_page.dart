//Plugins
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/signin_page.dart';
//Utils
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/utils/validator.dart';
//Theme
import 'package:auth/theme/text.dart';
import 'package:auth/theme/colors.dart';
//Widgets
import 'package:auth/widgets/sign_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _repasswordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusDate = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusRePassword = FocusNode();

  bool _isProcessing = false;

  final controller = ScrollController();
  double offset = 0;

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  DateTime? _chosenDate;
  bool _dateChosen = false;

  bool _isButtonDisabled = true;

  register() async {
    setState(() {
      _isProcessing = true;
    });

    if (_registerFormKey.currentState!.validate()) {
      User? user = await FireAuth.registerUsingEmailPassword(
        name: _nameTextController.text,
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      setState(() {
        _isProcessing = false;
      });

      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => ProfilePage(user: user),
          ),
          ModalRoute.withName('/'),
        );
      }
    }
  }

  validate(String? value) {
    if (_nameTextController.text.isNotEmpty &&
        _dateTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _repasswordTextController.text.isNotEmpty) {
      setState(() {
        if (_registerFormKey.currentState!.validate()) {
          setState(() {
            _isButtonDisabled = false;
          });
        } else {
          setState(() {
            _isButtonDisabled = true;
          });
        }
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

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
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusName.unfocus();
          _focusDate.unfocus();
          _focusEmail.unfocus();
          _focusPassword.unfocus();
          _focusRePassword.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            controller: controller,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 50.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Nazwa Apki',
                          style: appNameSign,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Rejestracja',
                            style: pageNameSign,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Form(
                          key: _registerFormKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _nameTextController,
                                focusNode: _focusName,
                                validator: (value) => Validator.validateName(
                                  name: value,
                                ),
                                style: signTextFormField,
                                decoration: CommonStyle.textFieldStyle(
                                  labelTextStr: "Nazwa",
                                ),
                                onChanged: validate,
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
                                      decoration: CommonStyle.textFieldStyle(
                                        labelTextStr: "Data Urodzenia",
                                      ),
                                      onChanged: validate,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _showDatePicker(context);
                                      },
                                      icon: const Icon(Icons.calendar_today),
                                      color: halfBlackColor,
                                    ),
                                  ]),
                              const SizedBox(height: 13.0),
                              TextFormField(
                                controller: _emailTextController,
                                focusNode: _focusEmail,
                                validator: (value) => Validator.validateEmail(
                                  email: value,
                                ),
                                style: signTextFormField,
                                decoration: CommonStyle.textFieldStyle(
                                  labelTextStr: "Adres Email",
                                  hintTextStr: "example@mail.com",
                                ),
                                onChanged: validate,
                              ),
                              const SizedBox(height: 13.0),
                              TextFormField(
                                controller: _passwordTextController,
                                focusNode: _focusPassword,
                                obscureText: true,
                                validator: (value) =>
                                    Validator.validatePassword(
                                  password: value,
                                ),
                                style: signTextFormField,
                                decoration: CommonStyle.textFieldStyle(
                                  labelTextStr: "Hasło",
                                ),
                                onChanged: validate,
                              ),
                              const SizedBox(height: 13.0),
                              TextFormField(
                                controller: _repasswordTextController,
                                focusNode: _focusRePassword,
                                obscureText: true,
                                validator: (value) =>
                                    Validator.validateRePassword(
                                  repassword: value,
                                  password: _passwordTextController.text,
                                ),
                                style: signTextFormField,
                                decoration: CommonStyle.textFieldStyle(
                                  labelTextStr: "Powtórz Hasło",
                                ),
                                onChanged: validate,
                              ),
                              const SizedBox(height: 13.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _isButtonDisabled
                                          ? null
                                          : () async {
                                              setState(() {
                                                _isProcessing = true;
                                              });

                                              if (_registerFormKey.currentState!
                                                  .validate()) {
                                                User? user = await FireAuth
                                                    .registerUsingEmailPassword(
                                                  name:
                                                      _nameTextController.text,
                                                  email:
                                                      _emailTextController.text,
                                                  password:
                                                      _passwordTextController
                                                          .text,
                                                );

                                                setState(() {
                                                  _isProcessing = false;
                                                });

                                                if (user != null) {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfilePage(
                                                              user: user),
                                                    ),
                                                    ModalRoute.withName('/'),
                                                  );
                                                }
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        primary: primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                        ),
                                      ),
                                      child: _isProcessing
                                          ? const SizedBox(
                                              child:
                                                  CircularProgressIndicator(),
                                              height: 27.0,
                                              width: 27.0,
                                            )
                                          : const Text(
                                              'Zarejestruj',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Masz już konto? ',
                              style: TextStyle(
                                color: halfBlackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 19.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Zaloguj',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
