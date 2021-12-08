//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_database/firebase_database.dart';
//Pages
//Utils
//Theme
import 'package:auth/theme/text.dart';
import 'package:auth/theme/colors.dart';
//Widgets
import 'package:auth/widgets/sign_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.reference();
  //final User? _currentUser = FirebaseAuth.instance.currentUser;

  List _needs = [];

  getList() async {
    List needs = [];

    ref.child('posts').onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      needs = [];
      values.forEach((key, values) {
        values['id'] = key;
        needs.add(values);
      });
      setState(() {
        _needs = needs;
      });
    });

    //print(_needs[0]['Name']);
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              GeneralWidgets.post(
                postTitle: "Poduszka z folii",
                profilePhotoUrl:
                    "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
                postMainPhotoUrl:
                    "https://images.unsplash.com/photo-1520899981500-21af7ff24c2a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80",
                postLikes: "205",
                postComents: "25",
                isLiked: true,
                onLiked: () {
                  print('Like');
                },
                onComment: () {
                  Navigator.of(context).push(CommentsOverlay());
                },
                onShared: () {
                  print("Share");
                },
                onPhoto: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PostPage(),
                    ),
                  );
                },
                onProfilePhoto: () {
                  print("Profile");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
