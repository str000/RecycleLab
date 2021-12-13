//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class LikedPage extends StatefulWidget {
  const LikedPage({Key? key}) : super(key: key);

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostPage(),
                ),
              );*/
            },
            onProfilePhoto: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PublicProfilePage(),
                ),
              );
            },
          ),
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
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostPage(),
                ),
              );*/
            },
            onProfilePhoto: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PublicProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
