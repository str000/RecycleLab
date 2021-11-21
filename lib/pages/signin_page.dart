//Plugins
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//Pages
import 'package:auth/pages/profile_page.dart';
import 'package:auth/pages/signup_page.dart';
//Utils
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/utils/validator.dart';
//Theme
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
//Widgets
import 'package:auth/widgets/sign_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
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
                                'Logowanie',
                                style: pageNameSign,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    validator: (value) =>
                                        Validator.validateEmail(
                                      email: value,
                                    ),
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Adres Email",
                                      hintTextStr: "example@mail.com",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                    },
                                  ),
                                  const SizedBox(height: 13.0),
                                  TextFormField(
                                      controller: _passwordTextController,
                                      focusNode: _focusPassword,
                                      obscureText: _obscureText,
                                      validator: (value) =>
                                          Validator.validatePassword(
                                            password: value,
                                          ),
                                      style: signTextFormField,
                                      decoration: CommonStyle.textFieldStyle(
                                        labelTextStr: "Hasło",
                                        suffIcon: IconButton(
                                          onPressed: _toggle,
                                          icon: _obscureText
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                        ),
                                      ),
                                      onChanged: (String? value) {
                                        _formKey.currentState!.validate();
                                      }),
                                  const SizedBox(height: 13.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            _focusEmail.unfocus();
                                            _focusPassword.unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isProcessing = true;
                                              });

                                              User? user = await FireAuth
                                                  .signInUsingEmailPassword(
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
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage(user: user),
                                                  ),
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
                                                  'Zaloguj',
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
                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Container(
                                    width: 130,
                                    height: 4,
                                    color: quarterBlackcolor,
                                  ),
                                ),
                                const Text(
                                  'lub',
                                  style: TextStyle(
                                    color: halfBlackColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Container(
                                    width: 130,
                                    height: 4,
                                    color: quarterBlackcolor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      User? user =
                                          await FireAuth.signInWithGoogle(
                                              context: context);
                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(user: user),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      padding: const EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        left: 20.0,
                                        right: 50.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Image(
                                            width: 26.0,
                                            height: 26.0,
                                            image: AssetImage(
                                                'assets/google_logo.png')),
                                        Text(
                                          'Zaloguj przez Google',
                                          style: TextStyle(
                                            color: halfBlackColor,
                                            fontSize: 20.0,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 13.0),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      /*User? user =
                                          await FireAuth.signInWithFacebook(
                                              context: context);
                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(user: user),
                                          ),
                                        );
                                      }*/
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          const Color.fromRGBO(24, 119, 242, 1),
                                      padding: const EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        left: 20.0,
                                        right: 30.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Image(
                                            width: 26.0,
                                            height: 26.0,
                                            image: AssetImage(
                                                'assets/facebook_logo.png')),
                                        Text(
                                          'Zaloguj przez Facebook',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                  'Nie masz konta? ',
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
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Zarejestruj',
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
                ));
          },
        ),
      ),
    );
  }
}
