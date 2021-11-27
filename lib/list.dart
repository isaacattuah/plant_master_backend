import 'package:flutter/material.dart';
import 'package:plant_master/page.dart';
import 'package:plant_master/random.dart';
import 'nature.dart';


List<Plant> plantList = [] ;
Set<Plant> savedPlant = {};


class PlantList extends StatefulWidget {
  const PlantList({Key? key}) : super(key: key);

  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {



  Future<List<Plant>> generatePlants(int number) async {
    for (var i = 0; i < number ; i++) {
      Future<Plant> futurePlant = fetchRandomPlant();
      plantList.add(await futurePlant);
    }
    return plantList;
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
Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Random Plant List'),
    backgroundColor: Colors.green,
    actions: <Widget>[IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)]
    ),
      body: FutureBuilder(
        future: generatePlants(15),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot.data);
          if(snapshot.data == null){
            return const Center(
                // child: Text("Loading...")
               child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green))
            );
          } else {

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final alreadySaved = savedPlant.contains(snapshot.data[index]);
                return ListTile(
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //       snapshot.data[index].picture
                  //   ),
                  // ),
                  title: Text(snapshot.data[index].scientificName),
                  subtitle: Text(snapshot.data[index].primaryCommonName),
                  trailing: IconButton(
                    icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved ? Colors.red : null),
                    onPressed: ()
                    {
                     setState(() {
                       if (alreadySaved) {
                         savedPlant.remove(snapshot.data[index]);
                       } else {
                         savedPlant.add(snapshot.data[index]);
                       }
                     });
                    },
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlantPage(snapshot.data[index]))
                      );
                    });
                  },
                );
              },
            );
          }
        }
      ),
    );
  }


}