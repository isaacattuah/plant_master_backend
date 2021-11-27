import 'package:flutter/material.dart';
import 'package:plant_master/list.dart';
import 'package:plant_master/random.dart';
import 'package:plant_master/search.dart';
import 'home.dart';



void main() {
  runApp(PlantMasterApp());
}

class PlantMasterApp extends StatelessWidget {
  const PlantMasterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Master MVP',
      routes: {
        // Open the welcome page widget
        // Open the welcome page widget
        "/": (context) => Home(),
        // When pressed is enter, open categories page
        '/random': (context) => RandomPlant(),
        '/list': (context) => PlantList(),
        '/search': (context) => SearchList()

      },
    );
  }
}
