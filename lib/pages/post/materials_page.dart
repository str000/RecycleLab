//Plugins
import 'package:auth/theme/colors.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 10),
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
                  const Text('Narzędzia',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      )),
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
              const SizedBox(height: 10),
              const Text(
                'Nożyczki',
                style: signTextFormField,
              ),
              const SizedBox(height: 10),
              const Text(
                'Klej',
                style: signTextFormField,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
