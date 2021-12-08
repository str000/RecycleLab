//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("Profile");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Dominika Kowalska',
                      style: documentsText,
                    ),
                    Text(
                      '@dominikakowalska',
                      style: postSmallName,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1520899981500-21af7ff24c2a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80'),
              ),
            ),
          ),
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
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Wytworzenie takiej poduszki to możliwość recyklingu około 20 butelek PET. Poduszka EKO jest puszysta i miękka. Dobrze dopasowuje się do ciała, do naturalnego ułożenia głowy i szyi podczas snu.',
              style: TextStyle(
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
