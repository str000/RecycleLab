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
  List needs;
  MaterialsPage({Key? key, required this.needs}) : super(key: key);

  @override
  _MaterialsPageState createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.needs[0]['categories'].length,
                itemBuilder: (BuildContext context, int index) {
                  return GeneralWidgets.material(
                    materialName:
                        "${widget.needs[0]['categories'][index][0].toString().toUpperCase()}${widget.needs[0]['categories'][index].toString().substring(1)}",
                    color: const Color.fromRGBO(251, 188, 5, 1),
                    onClick: () {},
                  );
                },
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.needs[0]['items'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.needs[0]['items'][index],
                            style: signTextFormField,
                          ))
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
