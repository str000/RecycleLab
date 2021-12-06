//Plugins
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:auth/theme/text.dart';

class DisabilitiesPage extends StatefulWidget {
  const DisabilitiesPage({Key? key}) : super(key: key);

  @override 
  _DisabilitiesPage createState() => _DisabilitiesPage();
}

class _DisabilitiesPage extends State<DisabilitiesPage> {

  double getFontSize(int index){
    if(index==0){return 14;}
    else if (index==1){return 17;}
    else if (index==2){return 20;}
    else {return 17;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  //------Pasek Górny------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Ustawienia',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //------Napis Ustawienia------
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Ułatwienia dostępu',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  //------Ustawienia------
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        //Rozmiar czcionki
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Rozmiar czcionki',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ToggleButtons(
                                    children: const [
                                      Text('A',style: TextStyle(fontSize: 14),),
                                      Text('A',style: TextStyle(fontSize: 17),),
                                      Text('A',style: TextStyle(fontSize: 20),),
                                    ],
                                    isSelected: isSelected,
                                    onPressed: (index) {
                                      for (var i=0; i<isSelected.length;i++){
                                        if(i==index){
                                          isSelected[i] = true;
                                        }else{
                                          isSelected[i] = false;
                                        }
                                      }

                                      setState((){fontSize = getFontSize(index);});
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}