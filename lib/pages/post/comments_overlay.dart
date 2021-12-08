import 'package:auth/theme/colors.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';

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
    return Dismissible(
      direction: DismissDirection.down,
      onDismissed: (_) {
        Navigator.of(context).pop();
      },
      key: Key("key"),
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
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      margin: const EdgeInsets.all(10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.star_rounded,
                      color: quarterBlackcolor,
                      size: 40,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: quarterBlackcolor,
                      size: 40,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: quarterBlackcolor,
                      size: 40,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: quarterBlackcolor,
                      size: 40,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: quarterBlackcolor,
                      size: 40,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height / 2 - 75,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
