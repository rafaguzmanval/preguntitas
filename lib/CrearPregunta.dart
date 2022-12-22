/*
*   Archivo: crear_tarea.dart
*
*   Descripción:
*   Formulario para crear una tarea para el usuario
*   Includes:
*   cloud_firestore.dart : Necesario para implementar los métodos que acceden a la base de datos
*   sesion.dart : Contiene los datos de la sesion actual (sirve de puntero a la página actual donde se encuentra el usuario)
*   video_player.dart : Necesario para cargar los videos del storage y cargarlos en el controlador de los reproductores de video.
*   rol.dart : Enumerado con los roles de usuarios que existen en la aplicacion.
*   acceso_bd.dart: Metodos de acceso a la base de datos.
*   material.dart: Se utiliza para dar colores y diseño a la aplicacion.
*   image_picker.dart : Libreria para acceder a la cámara y a la galería de imagenes del dispositivo.
*   tarea.dart: Se utiliza para construir el objeto tarea y enviarlo a la base de datos
* */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preguntitas/arasaac.dart';


class CrearPregunta extends StatefulWidget {
  @override
  CrearPreguntaState createState() => CrearPreguntaState();
}

// Clase para crear tarea
class CrearPreguntaState extends State<CrearPregunta> {
  //AccesoBD base = new AccesoBD();
  var tipoElegido = "NINGÚN TIPO ELEGIDO";
  var tipo;
  var fotoTomada;

  var creando = false;
  var rol = "administrador";

  final controladorNombre = TextEditingController();
  final controladorRespuesta1 = TextEditingController();
  final controladorRespuesta2 = TextEditingController();
  final controladorRespuesta3 = TextEditingController();
  final controladorRespuesta4 = TextEditingController();


  ///Cuándo se pasa de página es necesario que todos los controladores de los formularios y de los reproductores de vídeo se destruyan.
  @override
  void dispose() {
    super.dispose();
    if (controladorNombre != null) controladorNombre.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Notificacion.showBigTextNotification(title: "Vaya vaya", body: "¿Que dices? ¿creando tu primera tarea?", fln: flutterLocalNotificationsPlugin);

    /*
    controladorStream.stream.listen((event) async{



    });*/

    //Sesion.paginaActual = this;
  }

  /// Este es el build de la clase MyHomePage que devuelve toda la vista génerica más la vista especial de cada usuario.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back,),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Center(
            child: Text(
              'CREA UNA NUEVA PREGUNTA',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          )),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            children: [

              if (rol == "alumno") ...[
                VistaAlumno(),
              ] else if (rol == "profesor") ...[
                VistaProfesor()
              ] else if (rol == "administrador") ...[
                VistaAdministrador()
              ]

            ],
          )),
    );
  }

  ///Este método devuelve toda la vista que va a ver el profesor en un Widget.
  Widget VistaProfesor() {
    return VistaAdministrador();
  }

  ///Este método devuelve toda la vista que va a ver el alumno en un Widget.
  Widget VistaAlumno() {
    Navigator.pop(context);
    return Container();
  }

  ///Este método devuelve toda la vista que va a ver el administrador en un Widget.
  Widget VistaAdministrador() {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 0,horizontal: 200),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              obscureText: false,
              maxLength: 40,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'INTRODUCE LA PREGUNTA *',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,)),
              controller: controladorNombre,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              obscureText: false,
              maxLength: 40,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'INTRODUCE RESPUESTA 1 *',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,)),
              controller: controladorRespuesta1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              obscureText: false,
              maxLength: 40,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'INTRODUCE RESPUESTA 2 *',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,)),
              controller: controladorRespuesta2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              obscureText: false,
              maxLength: 40,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'INTRODUCE RESPUESTA 3 *',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,)),
              controller: controladorRespuesta3,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              obscureText: false,
              maxLength: 40,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'INTRODUCE RESPUESTA 4 *',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,)),
              controller: controladorRespuesta4,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "ELIGE UN PICTOGRAMA: *",
            style: TextStyle(
                fontSize: 30.0, height: 2.0),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              child: Text(
                "ELIGE FOTO PA LA PREGUNTA",
              ),
              onPressed: () async {
                fotoTomada = await buscadorArasaac(context: context);
                actualizar();
              }),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2,)),
            height: 150,
            width: 230,
            child: fotoTomada == null
                ? Center(
                child: Text(
                  'NINGÚN PICTOGRAMA ELEGIDO ****',
                  textAlign: TextAlign.center,
                ))
                : Stack(
              children: [
                Center(
                    child: fotoTomada is String
                        ? Image.network(fotoTomada)
                        : Image.network(fotoTomada)),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        fotoTomada = null;
                        actualizar();
                      },
                      child: Icon(
                        Icons.remove,
                      )),
                  alignment: Alignment.topLeft,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
              visible: !creando,
              child: Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.save,
                    ),
                    onPressed: () {
                      crearTablon();
                    },
                  ))),
          SizedBox(
            height: 10,
          ),
          Visibility(visible: creando, child: new CircularProgressIndicator()),
        ],
      ),
    );
  }

  //Método para crear tarea
  crearTablon() async {
    if (controladorNombre.text.isNotEmpty) {
      creando = true;
      actualizar();

      var nombre = "" + controladorNombre.text;

      var imagenes = "";
      if (fotoTomada != null) {
        if (fotoTomada is String) {
          if (fotoTomada.startsWith("http")) {
            imagenes = fotoTomada;
          }
        }
      }

      if (tipoElegido == "Tipo.sustantivo") {
        tipo = "sustantivo";
      } else if (tipoElegido == "Tipo.verbo") {
        tipo = "verbo";
      } else if (tipoElegido == "Tipo.adjetivo") tipo = "adjetivo";

     // Tablon tablon = Tablon();
      //tablon.setTablon(nombre, imagenes, tipo);
      /*await base.crearTablon(tablon).then((value) {
        creando = false;
        if (value) {
          controladorNombre.text = "";
          fotoTomada = null;
          displayMensajeValidacion(
              "TABLON CREADO CORRECTAMENTE\nPUEDES VOLVER A CREAR OTRO BOTON:",
              false);
        } else {
          displayMensajeValidacion(
              "FALLO AL CREAR TABLON, INTÉNTELO DE NUEVO", true);
        }

        actualizar();
      });*/
    } else {
      displayMensajeValidacion("ES NECESARIO RELLENAR TODOS LOS CAMPOS", true);
      actualizar();
    }
  }

  displayMensajeValidacion(mensajeDeValidacion, error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 2),
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: Color(error ? 0xFFC72C41 : 0xFF6BFF67),
              borderRadius: BorderRadius.all(Radius.circular(29)),
            ),
            child: Center(
                child: Text(mensajeDeValidacion,
                    style: TextStyle())),
          )),
    );
  }

  // Actualizar las páginas
  void actualizar() async {
    setState(() {});
  }
}
