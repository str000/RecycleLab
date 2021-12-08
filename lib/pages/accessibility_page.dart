//Plugins
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colorFilters.dart';
//Firebase Package
//Pages
//Utils
//Theme
//Widgets

bool colorFilterSwitchValue = false;

ColorFilter returnColorFilter(bool colorFilterSwitchValue){
  if(colorFilterSwitchValue == true){
    return sepia;
  }else{
    return identity;
  }
}

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {

  @override
  void initState(){
    colorFilterSwitchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoSwitch(
            value: colorFilterSwitchValue,
            onChanged: (value) {
              setState(() {
                colorFilterSwitchValue = value;
                print(colorFilterSwitchValue);
              });
            },
          ),
        ],
      ),
    );
  }
}
