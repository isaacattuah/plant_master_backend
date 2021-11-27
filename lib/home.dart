import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key:key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text('Plant Master MVP', style: TextStyle(fontSize: 20.0))),
            Column(
              children: [

                Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text(
                    'Random',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/random');
                  },
                ),
              ),

                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    child: const Text(
                      'Random List',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/list');
                    },
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    child: const Text(
                      'Search',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                ),


              ]
            )
          ],
        ),

      ),
    );
  }
}

