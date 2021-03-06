//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final ref = FirebaseDatabase.instance.reference();

  List _needs = [];
  List _user = [];
  late List _liked;

  @override
  void initState() {
    super.initState();
    _liked = [];
    ref.child('posts').onValue.listen((event) async {
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
    });
    ref.child('users/' + _currentUser!.uid).onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];
      needs.add(values);
      setState(() {
        _user = needs;
        _liked = needs[0]['likedPostsID'];
      });
    });
  }

  Future<String> downloadProfilePhoto(String postID) async {
    final ref = FirebaseStorage.instance.ref('posts/' + postID + '/photo0');
    var url = await ref.getDownloadURL();
    return url.toString();
  }

  Future<String> downloadProfileUserPhoto(String userID) async {
    final ref =
        FirebaseStorage.instance.ref('users/' + userID + '/profile-photo.png');
    var url = await ref.getDownloadURL();
    return url.toString();
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
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _needs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                          future: Future.wait([
                            downloadProfilePhoto(_needs[index]['id']),
                            downloadProfileUserPhoto(_needs[index]['authorID'])
                          ]),
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GeneralWidgets.post(
                                postTitle: _needs[index]['title'],
                                profilePhotoUrl: snapshot.data![1],
                                postMainPhotoUrl: snapshot.data![0],
                                postLikes: _needs[index]['likes'] ?? '0',
                                postComents: _needs[index]['comments'] ?? '0',
                                isLiked: false,
                                onLiked: () {},
                                onComment: () {
                                  Navigator.of(context).push(CommentsOverlay(
                                      _needs[index]['comments']));
                                },
                                onShared: () {
                                  print("Share");
                                },
                                onPhoto: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PostPage(postID: _needs[index]['id']),
                                    ),
                                  );
                                },
                                onProfilePhoto: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PublicProfilePage(
                                          userID: _needs[index]['authorID']),
                                    ),
                                  );
                                },
                              );
                            }
                            return Container(
                              color: Colors.orange,
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
