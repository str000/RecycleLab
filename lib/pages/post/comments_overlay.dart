import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentsOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.2);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

//Navigator.pop(context)
  Widget _buildOverlayContent(BuildContext context) {
    final _commentTextController = TextEditingController();
    final _focusComment = FocusNode();
    bool _isRated = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            _focusComment.unfocus();
          },
          child: Dismissible(
            direction: DismissDirection.down,
            onDismissed: (_) {
              Navigator.of(context).pop();
            },
            key: const Key("key"),
            child: AnimatedContainer(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              duration: const Duration(milliseconds: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 75,
                              decoration: const BoxDecoration(
                                color: quarterBlackcolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              margin: const EdgeInsets.all(10),
                            ),
                          ],
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            if (v == 0.0) {
                              setState(() {
                                _isRated = false;
                              });
                            } else {
                              setState(() {
                                _isRated = true;
                              });
                            }
                          },
                          starCount: 5,
                          size: 40.0,
                          isReadOnly: false,
                          filledIconData: Icons.star_rounded,
                          defaultIconData: Icons.star_rounded,
                          color: const Color.fromRGBO(251, 188, 5, 1),
                          borderColor: quarterBlackcolor,
                          spacing: 0.0,
                        ),
                        _isRated
                            ? Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height / 2 - 75,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    const DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                            ),
                                                            Positioned.fill(
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {},
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'Ty',
                                                        style:
                                                            signTextFormField,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SmoothStarRating(
                                                allowHalfRating: false,
                                                onRated: (v) {},
                                                starCount: 5,
                                                size: 25.0,
                                                rating: 0,
                                                isReadOnly: true,
                                                filledIconData:
                                                    Icons.star_rounded,
                                                defaultIconData:
                                                    Icons.star_rounded,
                                                color: const Color.fromRGBO(
                                                    251, 188, 5, 1),
                                                borderColor: quarterBlackcolor,
                                                spacing: 0.0,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          GeneralWidgets.line(),
                                          TextFormField(
                                            controller: _commentTextController,
                                            focusNode: _focusComment,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: 'Komentarz',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                            onChanged: (String? value) {},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                primary: primaryColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                ),
                                              ),
                                              child: const Text(
                                                'Dodaj Komentarz',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(width: 0),
                        _isRated
                            ? const SizedBox(width: 0)
                            : Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height / 2 - 75,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        GeneralWidgets.comment(
                                          commentUserName: 'Kowalski',
                                          commentPhotoUrl:
                                              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                                          comment: 'Świetny pomysł. Polecam!',
                                          onProfilePhoto: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ).drive(
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero),
      ),
      child: child,
    );
  }
}
