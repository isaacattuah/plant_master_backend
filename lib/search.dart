import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_master/nature.dart';
import 'page.dart';
import 'package:plant_master/list.dart';



class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  late List<Plant> plants;
  String query = "Aloe";
  bool _isLoading = true;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = const Text("AppBar");

  Map<String, dynamic> searchJSON = {
    "criteriaType" : "species",
    "textCriteria" : [
      {
        "paramType": "quickSearch",
        "searchToken": 'Aloe',
      }
    ],
    "statusCriteria" : [ ],
    "locationCriteria" : [ ],
    "pagingOptions" : {
      "page" : null,
      "recordsPerPage" : null
    },
    "recordSubtypeCriteria" : [ ],
    "modifiedSince" : null,
    "locationOptions" : null,
    "classificationOptions" : null,
    "speciesTaxonomyCriteria" : [
      {
        "paramType": "informalTaxonomy",
        "informalTaxonomy": "Plants"
      }
    ]
  };



  Future<List<Plant>> getPlant() async {
    String url = "https://explorer.natureserve.org/api/data/speciesSearch";
    var response = await post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(searchJSON),
        encoding: Encoding.getByName("utf-8"));


    Map json = jsonDecode(response.body);

    //print(json);
    List _plantList = [];

    for (var i in json['results']) {
      _plantList.add(i);

    }
    //print(_plantList);
    return Plant.plantsFromSnapshot(_plantList);
  }

  Future<void> getPlants() async {
    plants = await getPlant();
    setState(() {
      _isLoading = false;
    });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = savedPlant.map((Plant p) {
        final alreadySaved = savedPlant.contains(p);
        return ListTile(
          title: Text(p.scientificName),
          subtitle: Text(p.primaryCommonName),
          trailing: IconButton(
            icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
            onPressed: ()
            {
              setState(() {
                if (alreadySaved) {
                  savedPlant.remove(p);
                } else {
                  savedPlant.add(p);
                }
              });
            },
          ),
          onTap: (){
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlantPage(p))
              );
            });
          },
        );
      });
      final List<Widget> divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: const Text('Saved Plant'),
            backgroundColor: Colors.green,
          ),

          body: ListView(children: divided));
    }));
  }




  @override
  void initState(){
    super.initState();
    getPlants();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: cusIcon, onPressed: (){
              setState(() {
                if(cusIcon.icon == Icons.search){
                  cusIcon = Icon(Icons.cancel);
                  cusSearchBar = const TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Scientific or Common Name"
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                    )
                  );
                }
                else{
                  cusIcon = Icon(Icons.search);
                  cusSearchBar = const Text("AppBar");
                }
              });
            }),
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)

          ],
          title: cusSearchBar
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final alreadySaved = savedPlant.contains(plants[index]);
            return ListTile(
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       snapshot.data[index].picture
              //   ),
              // ),
              title: Text(plants[index].scientificName),
              subtitle: Text(plants[index].primaryCommonName),
              trailing: IconButton(
                icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null),
                onPressed: ()
                {
                  setState(() {
                    if (alreadySaved) {
                      savedPlant.remove(plants[index]);
                    } else {
                      savedPlant.add(plants[index]);
                    }
                  });
                },
              ),
              onTap: (){
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlantPage(plants[index]))
                  );
                });
              },
            );
          },
        ));
  }

}
