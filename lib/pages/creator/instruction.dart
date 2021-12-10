import 'package:flutter/material.dart';

class Intruction extends StatefulWidget {
  const Intruction({Key? key}) : super(key: key);

  @override
  _Intruction createState() => _Intruction();
}

class _Intruction extends State<Intruction>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Intruction'),
        ],
      ),
    );
  }
}