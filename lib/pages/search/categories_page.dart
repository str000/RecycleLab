//Plugins
import 'package:auth/theme/colors.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class CategoriesPage extends StatelessWidget {
  final ValueChanged<String> category;
  const CategoriesPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralWidgets.category(
                  categoryName: "Pojemniki",
                  icon: Icons.liquor_rounded,
                  onClick: () {
                    category('pojemniki');
                  },
                  context: context,
                ),
                GeneralWidgets.category(
                  categoryName: "Materiały Budowlane",
                  icon: Icons.construction_rounded,
                  onClick: () {
                    category('materiały budowlane');
                  },
                  context: context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralWidgets.category(
                  categoryName: "Elektronika",
                  icon: Icons.electrical_services_rounded,
                  onClick: () {
                    category('elektronika');
                  },
                  context: context,
                ),
                GeneralWidgets.category(
                  categoryName: "Guma",
                  icon: Icons.waves_rounded,
                  onClick: () {
                    category('guma');
                  },
                  context: context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralWidgets.category(
                  categoryName: "Środki Czystości",
                  icon: Icons.clean_hands_rounded,
                  onClick: () {
                    category('środki czystości');
                  },
                  context: context,
                ),
                GeneralWidgets.category(
                  categoryName: "Meble",
                  icon: Icons.chair_rounded,
                  onClick: () {
                    category('meble');
                  },
                  context: context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralWidgets.category(
                  categoryName: "Artykuły Biurowe",
                  icon: Icons.edit_rounded,
                  onClick: () {
                    category('artykuły biurowe');
                  },
                  context: context,
                ),
                GeneralWidgets.category(
                  categoryName: "Kosmetyki",
                  icon: Icons.sanitizer_rounded,
                  onClick: () {
                    category('kosmetyki');
                  },
                  context: context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.more_horiz,
                              size: 35,
                              color: halfBlackColor,
                            ),
                            Text(
                              'Inne',
                              style: TextStyle(
                                fontSize: 12.0,
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
                            onTap: () {
                              category('inne');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
