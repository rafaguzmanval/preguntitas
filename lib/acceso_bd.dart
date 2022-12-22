
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
     await db.collection("preguntas")
   }

}