//Plugins
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import 'package:auth/pages/profile_page.dart';
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
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  final controller = ScrollController();
  double offset = 0;

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
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
                    children: [
                      Column(
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
                          ),
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
                          ),
                          const SizedBox(height: 13.0),
                          TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: true,
                            validator: (value) => Validator.validatePassword(
                              password: value,
                            ),
                            style: signTextFormField,
                            decoration: CommonStyle.textFieldStyle(
                              labelTextStr: "Hasło",
                            ),
                          ),
                          const SizedBox(height: 13.0),
                          _isProcessing
                              ? const CircularProgressIndicator()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isProcessing = true;
                                          });

                                          if (_registerFormKey.currentState!
                                              .validate()) {
                                            User? user = await FireAuth
                                                .registerUsingEmailPassword(
                                              name: _nameTextController.text,
                                              email: _emailTextController.text,
                                              password:
                                                  _passwordTextController.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(user: user),
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
                                        child: const Text(
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
                      const SizedBox(height: 50.0),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
