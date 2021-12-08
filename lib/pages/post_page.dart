//Plugins
import 'package:auth/pages/post/general_page.dart';
import 'package:auth/pages/post/materials_page.dart';
import 'package:auth/pages/post/tutorial_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Column(
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
                    const Text(
                      'Poduszka z folii',
                      style: documentsText,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                GeneralWidgets.line(),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                        primary:
                            currentIndex == 0 ? Colors.black : halfBlackColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            currentIndex = 0;
                          },
                        );
                      },
                      child: const Text("Ogólne"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                        primary:
                            currentIndex == 1 ? Colors.black : halfBlackColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            currentIndex = 1;
                          },
                        );
                      },
                      child: const Text("Materiały"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                        primary:
                            currentIndex == 2 ? Colors.black : halfBlackColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            currentIndex = 2;
                          },
                        );
                      },
                      child: const Text("Instrukcja"),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                GeneralWidgets.line(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 153,
            child: IndexedStack(
              children: const <Widget>[
                GeneralPage(),
                MaterialsPage(),
                TutorialPage(),
              ],
              index: currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}
