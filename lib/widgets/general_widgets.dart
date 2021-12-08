//Plugins
import 'package:auth/theme/text.dart';
import 'package:flutter/material.dart';
//Theme
import 'package:auth/theme/colors.dart';

class GeneralWidgets {
  static Container line() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: quarterBlackcolor,
      ),
    );
  }

  static SizedBox post({
    String postTitle = "",
    String profilePhotoUrl = "",
    String postMainPhotoUrl = "",
    String postLikes = "",
    String postComents = "",
    bool isLiked = false,
    final onLiked,
    final onComment,
    final onShared,
    final onPhoto,
    final onProfilePhoto,
  }) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          GeneralWidgets.line(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                postTitle,
                style: postTitleStyle,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(profilePhotoUrl),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onProfilePhoto,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(postMainPhotoUrl),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onPhoto,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
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
                onPressed: onLiked,
                child: Row(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? likeColor : halfBlackColor,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      postLikes,
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
                onPressed: onComment,
                child: Row(
                  children: [
                    const Icon(
                      Icons.mode_comment_outlined,
                      color: halfBlackColor,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      postComents,
                      style: signTextFormField,
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: halfBlackColor,
                ),
                onPressed: onShared,
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
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  static Container material({
    String materialName = "",
    required Color color,
    final onClick,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 5,
        bottom: 5,
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
            ),
            child: Text(
              materialName,
              style: documentsText,
            ),
          ),
        ),
      ),
    );
  }

  static Column comment({
    String commentUserName = "",
    String commentPhotoUrl = "",
    String comment = "",
    final onProfilePhoto,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(commentPhotoUrl),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onProfilePhoto,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      commentUserName,
                      style: signTextFormField,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.star_rounded,
                  color: quarterBlackcolor,
                  size: 20,
                ),
                Icon(
                  Icons.star_rounded,
                  color: quarterBlackcolor,
                  size: 20,
                ),
                Icon(
                  Icons.star_rounded,
                  color: quarterBlackcolor,
                  size: 20,
                ),
                Icon(
                  Icons.star_rounded,
                  color: quarterBlackcolor,
                  size: 20,
                ),
                Icon(
                  Icons.star_rounded,
                  color: quarterBlackcolor,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        GeneralWidgets.line(),
        const SizedBox(height: 10),
        Text(
          comment,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
