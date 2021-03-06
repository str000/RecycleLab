//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme
import 'package:flutter_slidable/flutter_slidable.dart';
//Widgets

class TutorialsPage extends StatefulWidget {
  const TutorialsPage({Key? key}) : super(key: key);

  @override
  _TutorialsPageState createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.reference();
  List _needs = [];

  @override
  void initState() {
    super.initState();

    ref.child('posts').onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];
      values.forEach((key, values) {
        values['id'] = key;

        if (values['authorID'] == _currentUser!.uid) {
          needs.add(values);
        }
      });
      setState(() {
        _needs = needs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _needs.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                closeOnScroll: false,
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              children: [
                                Container(
                                  height: 60,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: quarterBlackcolor,
                                  ),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: likeColor,
                                    size: 30,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              children: [
                                Container(
                                  height: 60,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: quarterBlackcolor,
                                  ),
                                  child: const Icon(
                                    Icons.edit_rounded,
                                    color: halfBlackColor,
                                    size: 30,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: contrastWhite,
                        ),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _needs[index]['title'],
                              style: documentsText,
                            ),
                            _needs[index]['public'] == true
                                ? const Icon(
                                    Icons.public_rounded,
                                    color: primaryColor,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.save_rounded,
                                    color: Color.fromRGBO(24, 192, 81, 1),
                                    size: 30,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
