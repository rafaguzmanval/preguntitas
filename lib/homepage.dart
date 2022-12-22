import 'package:flutter/material.dart';
import 'package:preguntitas/creacion_cuestionario.dart';
import 'package:preguntitas/CrearPregunta.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var rol = 'usuario';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Column(children: [
              Center(
                child: Text(
                  'Menú principal'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              )
            ]),
            automaticallyImplyLeading: false,
          ),
          body: Container(margin: EdgeInsets.all(5), child: rol=='administrador'?vistaAdmin():vistaAlumno()),
    );
  }

  vistaAdmin(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: ()async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CrearPregunta()));
    }, child: Text('Crear Cuestionario'))
      ],
    );
  }

  vistaAlumno(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Cuestionario()));
        },
            child: Text('Resolver Cuestionario'))
      ],
    );
  }
}