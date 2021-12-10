import 'package:flutter/material.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  _TitlePage createState() => _TitlePage();
}

class _TitlePage extends State<TitlePage>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('TitlePage'),
        ],
      ),
    );
  }
}