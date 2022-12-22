import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var rol = 'administrador';

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
        ElevatedButton(onPressed: (){}, child: Text('Crear Cuestionario'))
      ],
    );
  }

  vistaAlumno(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: (){}, child: Text('Resolver Cuestionario'))
      ],
    );
  }
}