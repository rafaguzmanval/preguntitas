import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  @override
  RegistroState createState() => RegistroState();
}

class RegistroState extends State<Registro> {
  int _counter = 0;
  final controllerISBN = TextEditingController();
  String titulo = '', autor = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controllerISBN,
              decoration: const InputDecoration(
                  hintText: 'Introduce un ISBN'
              ),
            ),
            Text(
              'Titulo: $titulo \n Autor: $autor',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Buscar',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
