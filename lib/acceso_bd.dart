
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:preguntitas/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccesoBD{

   static var db = FirebaseFirestore.instance;


   static comprobarNick(nick) async
   {
     return await db.collection("usuarios").where("nick" , isEqualTo: nick).get().then((result){

       if(result.size == 0)
         {
           print(result.docs[0].id);
           return null;
         }
       else
         {
           return result.docs[0].get("tipo");
         }

     });
   }

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

     Map<String,dynamic> preguntita = {
       'pregunta':pregunta.get("pregunta"),
       'respuestas' : pregunta.get("respuestas")
     };

     return preguntita;
   }

   static addPregunta(String pregunta,List respuestas) async
   {
     Map<String,dynamic> nueva = {
       'pregunta': pregunta,
       'respuestas' : respuestas
     };
     await db.collection("preguntas").add(nueva);
   }

}