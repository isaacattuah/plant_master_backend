import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'nature.dart';
import 'package:plant_master/photos.dart';

String? plantImg;

Future<Plant> fetchRandomPlant() async {
  // Animal Range Approximation (100002 - 125003)
  // Plant Range Approximation (125003 - 161769)
  // Non-Vascular Plants and Fungus (125003 - 127851)
  // Vascular Plant [The focus of our app] (127851-161769)

  var response;

  do {
    int lowId = 127851;
    int highId = 161769;
    Random number = Random();
    String elementID = (lowId + number.nextInt(highId - lowId)).toString();
    String url = 'https://explorer.natureserve.org/api/data/taxon/ELEMENT_GLOBAL.2.$elementID';
    response = await http.get(Uri.parse(url));
  }
  while (response.statusCode != 200);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // final jsonData = response.body;
    // final parsedJson = jsonDecode(jsonData);
    //
    // print('${parsedJson.runtimeType} : $parsedJson \n');
    Plant a = Plant.fromJson(jsonDecode(response.body));
    plantImg = await fetchPhoto(a.scientificName);

    return a ;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load plant card');

  }
}




Future<String> fetchPhoto(String query) async {
  var response;
  do {
    Map<String, dynamic> searchJSON = {
      "engine": "google",
      "q" : "",
      "api_key": "c36f9742694de0e993dd584d46b552406398f66348f1036519726d6ecb977171"
    };
    searchJSON["q"] = query.replaceAll(" ", '+');
    String url = "https://serpapi.com/search.json?engine=${searchJSON["engine"]}&q=${searchJSON["q"]}&google_domain=google.com&tbm=isch&num=1&ijn=1&api_key=${searchJSON["api_key"]}";
    //print(url);
    response = await http.get(Uri.parse(url));
  }
  while (response.statusCode != 200);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // final jsonData = response.body;
    // final parsedJson = jsonDecode(jsonData);
    //
    // print('${parsedJson.runtimeType} : $parsedJson \n');

    Photo a = Photo.fromJson(jsonDecode(response.body));
    print(a.photo_url);
    return(a.photo_url);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load plant image');

  }
}





void main() => runApp(const RandomPlant());

class RandomPlant extends StatefulWidget {
  const RandomPlant({Key? key}) : super(key: key);

  @override
  _RandomPlantState createState() => _RandomPlantState();
}

class _RandomPlantState extends State<RandomPlant> {
  late Future<Plant> futurePlant;
  //late Future<String> futurePhoto;




  @override
  void initState() {
    super.initState();
    futurePlant = fetchRandomPlant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Plant'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: FutureBuilder<Plant>(
            future: futurePlant,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String query = snapshot.data!.scientificName;

                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(plantImg!),
                        Text(snapshot.data!.scientificName),
                        Text(snapshot.data!.primaryCommonName),
                        // Text(snapshot.data!.taxonomicComments),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                          ),
                          onPressed: () {
                            setState(() {
                              futurePlant = fetchRandomPlant();
                            });
                          },
                          child: const Text('Generate Plant'),
                        )

                      ]),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      );

  }
}