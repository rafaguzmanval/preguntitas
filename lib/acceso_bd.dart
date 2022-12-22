
import 'package:firebase_core/firebase_core.dart';
import 'package:preguntitas/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccesoBD{

   static var db = FirebaseFirestore.instance;


   cogerInformacion()async{

     await db.collection("usuarios").get().then((consulta){

     });
   }

   registrarUsuario(nick) async{
     Map<String,dynamic> usuario = {
       'nick':nick,
       'tipo' : "usuario"
     };
     await db.collection("usuarios").add(usuario);
   }
}