
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:preguntitas/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccesoBD{

   static var db = FirebaseFirestore.instance;



   static registrarUsuario(nick) async{
     Map<String,dynamic> usuario = {
       'nick':nick,
       'tipo' : "usuario"
     };
     await db.collection("usuarios").add(usuario);
   }

   static consultarNuevaPregunta() async{
     var consulta = await db.collection("preguntas").get();
     var pregunta = consulta.docs[Random().nextInt(consulta.size)];
     print(pregunta.get("pregunta"));
     print(pregunta.get("respuestas"));
   }

   static addPregunta(pregunta,respuestas) async
   {
     Map<String,dynamic> nueva = {
       'pregunta': pregunta,
       'respuestas' : respuestas
     };
     await db.collection("preguntas").add(nueva);
   }

}