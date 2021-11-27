import 'package:flutter/material.dart';
import 'nature.dart';

class PlantPage extends StatelessWidget {
  //const PlantPage({Key? key}) : super(key: key);

  final Plant plant;

  PlantPage(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(plant.scientificName),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(plant.scientificName),
                Text(plant.primaryCommonName),
                Text(plant.taxonomicComments),
                Text(plant.informalTaxonomy),
                Text(plant.Kingdom),
                Text(plant.Phylum),
                Text(plant.Class),
                Text(plant.Order),
                Text(plant.Family),
                Text(plant.Genus),
              ],
    ),
        )
    );
  }
}
