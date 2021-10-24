import 'package:flutter/material.dart';
import 'package:francy_zapata_7_2021_2_p1/screens/memes_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEMES PARA LOS DESOCUPADOS',
      home: memesListScreen(),
    );
  }
}
