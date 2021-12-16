import 'dart:convert';
import 'package:flutter/material.dart';
import 'nature.dart';
import 'photos.dart';
import 'package:http/http.dart' as http;





Future<Photo> fetchPhotoPage(String query) async {
  var response;
  do {
    Map<String, dynamic> searchJSON = {
      "engine": "google",
      "q" : "",
      "api_key": "c36f9742694de0e993dd584d46b552406398f66348f1036519726d6ecb977171"
    };
    searchJSON["q"] = query.replaceAll(" ", '+');
    String url = "https://serpapi.com/search.json?engine=${searchJSON["engine"]}&q=${searchJSON["q"]}&google_domain=google.com&tbm=isch&num=1&ijn=1&api_key=${searchJSON["api_key"]}";

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
    //print(a.photo_url);
   return a;


  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load plant card');

  }
}




class PlantPage extends StatefulWidget {


  //const PlantPage({Key? key}) : super(key: key);
  Plant plant;
  PlantPage(this.plant);

  @override
  State<PlantPage> createState() => _PlantPageState();
}




class _PlantPageState extends State<PlantPage> {
  late Future<Photo> plantImage;

  @override
  void initState() {

    super.initState();
    plantImage = fetchPhotoPage(widget.plant.scientificName);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.plant.scientificName),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<Photo>(
          future: plantImage,
          builder: (context,snapshot) {
            if (snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(snapshot.data!.photo_url),
                    Text(widget.plant.scientificName),
                    Text(widget.plant.primaryCommonName),
                    Text(widget.plant.taxonomicComments),
                    Text(widget.plant.informalTaxonomy),
                    Text(widget.plant.Kingdom),
                    Text(widget.plant.Phylum),
                    Text(widget.plant.Class),
                    Text(widget.plant.Order),
                    Text(widget.plant.Family),
                    Text(widget.plant.Genus),
                  ],
                ),
              );
            }
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )
    );
  }
}

