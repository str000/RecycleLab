//Plugins
import 'package:auth/theme/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class TutorialPage extends StatefulWidget {
  List needs;
  TutorialPage({Key? key, required this.needs}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  List photos = [];

  Future<String> downloadProfilePhoto(int index) async {
    final ref = FirebaseStorage.instance
        .ref('posts/' + widget.needs[0]['id'] + '/photo' + index.toString());
    var url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.needs[0]['postStructure']['texts'].length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 1,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: quarterBlackcolor,
                          ),
                        ),
                        Text(
                          'Krok ' + (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: quarterBlackcolor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                        future: Future.wait([downloadProfilePhoto(index)]),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data![0]),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
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
                            );
                          }
                          return Container(
                            color: Colors.orange,
                          );
                        }),
                    const SizedBox(height: 20),
                    Text(
                      widget.needs[0]['postStructure']['texts'][index],
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: halfBlackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
