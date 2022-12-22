import 'package:flutter/material.dart';
import 'acceso_bd.dart';

class Cuestionario extends StatefulWidget {
  @override
  CuestionarioState createState() => CuestionarioState();
}

class CuestionarioState extends State<Cuestionario> {
  int _counter = 0;
  final controllerISBN = TextEditingController();
  String pregunta = '';
  var respuesta ;
  List<String> items = <String>['Normal','Admin'];

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
            Container(
              width: 500,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                      pregunta
                  ),
                  if(respuesta == null)...{
                    Text(
                        ''
                    ),
                  } else
                  Text(
                    respuesta.toString()
                  ),
                ],
              )

              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var preg = await AccesoBD.consultarNuevaPregunta();
          setState(() {
            pregunta = preg['pregunta'];
            respuesta = preg['respuestas'];
          });
        },
        tooltip: 'Nueva preg',
        child: const Icon(Icons.question_answer),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
