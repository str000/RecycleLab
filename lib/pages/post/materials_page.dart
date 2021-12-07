//Plugins
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  _MaterialsPageState createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Center(
        child: Column(
          children: [
            GeneralWidgets.material(
              materialName: "Folia",
              color: const Color.fromRGBO(251, 188, 5, 1),
              onClick: () {},
            ),
            GeneralWidgets.material(
              materialName: "Butelka plastikowa",
              color: const Color.fromRGBO(251, 188, 5, 1),
              onClick: () {},
            ),
            GeneralWidgets.material(
              materialName: "Papier",
              color: const Color.fromRGBO(66, 133, 244, 1),
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
