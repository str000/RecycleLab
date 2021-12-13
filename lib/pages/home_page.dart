//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    await ref.child('posts').onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];
      values.forEach((key, values) {
        values['id'] = key;

        if (values['public'] == true) {
          needs.add(values);
        }
      });
      setState(() {
        _needs = needs;
      });
      for (int x = 0; x >= _needs.length; x++) {
        downloadProfilePhoto(_needs[x]['id'], x);
      }
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  Future<void> downloadProfilePhoto(String postID, int index) async {
    final ref = FirebaseStorage.instance.ref('posts/' + postID + '/photo0');
    var url = await ref.getDownloadURL();
    setState(() {
      _needs[index]['url'] = url;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _needs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GeneralWidgets.post(
                      postTitle: _needs[index]['title'],
                      profilePhotoUrl:
                          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
                      postMainPhotoUrl: _needs[index]['url'] ?? '',
                      postLikes: "205",
                      postComents: "25",
                      isLiked: true,
                      onLiked: () {
                        print('Like');
                        downloadProfilePhoto(_needs[index]['id'], index);
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PublicProfilePage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
