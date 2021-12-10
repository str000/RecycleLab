import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChooseItems extends StatefulWidget {
  const ChooseItems({Key? key}) : super(key: key);

  @override
  _ChooseItems createState() => _ChooseItems();
}

class _ChooseItems extends State<ChooseItems> {
  final myController = TextEditingController();

  final ref = FirebaseDatabase.instance.reference();
  String? providedNeedName;
  List _needs = [];
  var categoryCurr = '';
  String guma = "guma";

  getList() {
    if (_needs.isEmpty || categoryCurr != guma) {
      ref.child('category/' + guma).once().then((event) async {
        var values = event.value;
          setState(() {
            _needs = values;
            categoryCurr = guma;
          });
        print(values);
      });
      print(guma);
    } else {
      print("pełna");
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 0, right: 20, top: 0, left: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 20, right: 20, top: 20, left: 20),
                        child: Text(
                          'Wybierz przedmioty',
                          style: documentsText,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          style: signTextFormField,
                          controller: myController,
                          decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "np. butelka",
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              providedNeedName = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _needs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(236, 236, 236, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${_needs[index].toString()[0].toUpperCase()}${_needs[index].toString().substring(1)}",
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w800,
                                        color: halfBlackColor,
                                      ),
                                    )
                                  ],
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
                        ),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _needs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(236, 236, 236, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_needs[index].toString()[0].toUpperCase()}${_needs[index].toString().substring(1)}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                      color: halfBlackColor,
                                    ),
                                  )
                                ],
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
                      ),
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
