//Plugins
import 'package:auth/theme/colors.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1520899981500-21af7ff24c2a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80"),
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
            ),
            const SizedBox(height: 20),
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
                const Text('Krok 1',
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
            const SizedBox(height: 20),
            const Text(
              'Przygotuj potrzebne narzędzia i materiały. Zaplanuj jaki kolor będzie przewodził Twojej poduszce i wybierz odpowiednie nitki do pracy.',
              style: TextStyle(
                fontSize: 18.0,
                color: halfBlackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
