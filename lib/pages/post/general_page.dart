//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class GeneralPage extends StatefulWidget {
  List needs;
  GeneralPage({Key? key, required this.needs}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final ref = FirebaseDatabase.instance.reference();
  List _user = [];
  bool isLiked = false;
  String profilePhoto = '';
  String mainPhoto = '';

  @override
  void initState() {
    super.initState();
    ref
        .child('users/' + widget.needs[0]['authorID'])
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];

      needs.add(values);

      setState(() {
        _user = needs;
      });
    });
  }

  Future<String> downloadProfilePhoto(String postID) async {
    final ref = FirebaseStorage.instance.ref('posts/' + postID + '/photo0');
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<String> downloadProfileUserPhoto(String authorID) async {
    final ref = FirebaseStorage.instance
        .ref('users/' + authorID + '/profile-photo.png');
    var url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: Row(
              children: [
                FutureBuilder(
                    future: Future.wait([
                      downloadProfileUserPhoto(widget.needs[0]['authorID'])
                    ]),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Stack(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot.data![0]),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PublicProfilePage(
                                                  userID: widget.needs[0]
                                                      ['authorID']),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        color: Colors.orange,
                      );
                    }),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dominika Kowalska',
                      style: documentsText,
                    ),
                    Text(
                      '@' + _user[0]['nameID'],
                      style: postSmallName,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
              future:
                  Future.wait([downloadProfilePhoto(widget.needs[0]['id'])]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(snapshot.data![0]),
                      ),
                    ),
                  );
                }
                return Container(
                  color: Colors.orange,
                );
              }),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                        primary: halfBlackColor,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? likeColor : halfBlackColor,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '205',
                            style: isLiked
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                    color: likeColor,
                                  )
                                : signTextFormField,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                        primary: halfBlackColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(CommentsOverlay());
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.mode_comment_outlined,
                            color: halfBlackColor,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '25',
                            style: signTextFormField,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: halfBlackColor,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.share,
                            color: halfBlackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
            ),
            child: GeneralWidgets.line(),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.needs[0]['desc'],
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
