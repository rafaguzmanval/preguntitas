
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:preguntitas/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preguntitas/registro.dart';

import 'firebase_options.dart';

var db = FirebaseFirestore.instance;
class Inicio extends StatefulWidget {
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  var usuarios;
  var imagenUgr;
  var maxUsuariosPorFila = 2;
  double offSetActual = 0;
  int anchoUsuarios = 130;
  int espacioEntreUsuarios = 72;

  bool verBotonAbajo = false, verBotonArriba = false;

  var homeController;
  var nombre = "cargando...";

  cogerInformacion()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await db.collection("usuarios").get().then((consulta){
       nombre = consulta.docs[0].get("nick");
       print(nombre);
       _actualizar();
    });
  }

  @override
  void initState() {


    super.initState();
    cogerInformacion();
    //obtenerAutenticacion();
    //inicializar();
    //Notificacion.showBigTextNotification(title: "Bienvenio", body: "LA gran notificacion", fln: flutterLocalNotificationsPlugin);
    //Sesion.reload();
    //Sesion.paginaActual = this;
    homeController = new ScrollController();
    homeController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (homeController.position.maxScrollExtent > 0) {
      if (homeController.offset >= homeController.position.maxScrollExtent &&
          !homeController.position.outOfRange) {
        setState(() {
          //Cuando llega al fondo del scroll
          verBotonAbajo = false;
          verBotonArriba = true;
        });
      }
      if (homeController.offset <= homeController.position.minScrollExtent &&
          !homeController.position.outOfRange) {
        setState(() {
          //Cuando está al empezar el scroll
          verBotonArriba = false;
          verBotonAbajo = true;
        });
      }

      if (homeController.offset > homeController.position.minScrollExtent &&
          homeController.offset < homeController.position.maxScrollExtent) {
        setState(() {
          verBotonArriba = true;
          verBotonAbajo = true;
        });
      }
    } else {
      verBotonArriba = false;
      verBotonAbajo = false;
    }
  }

  // Contructor de la estructura de la pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back,),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Center(
                child: Text(
                  'Preguntas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ))),
        body: Stack(children: [
          ListaUsuarios(),
          Visibility(
            visible: verBotonArriba,
            child: Container(
              alignment: FractionalOffset(0.98, 0.01),
              child: FloatingActionButton(
                  heroTag: "botonUp",
                  child: Icon(
                    Icons.arrow_upward,
                  ),
                  elevation: 1.0,
                  onPressed: () {
                    offSetActual -= 150.0;
                    if (offSetActual <=
                        homeController.position.minScrollExtent) {
                      offSetActual = homeController.position.minScrollExtent;
                    } else {
                      verBotonAbajo = true;
                    }

                    _actualizar();

                    homeController.animateTo(
                      offSetActual, // change 0.0 {double offset} to corresponding widget position
                      duration: Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  }),
            ),
          ),
          Visibility(
            visible: verBotonAbajo,
            child: Container(
              alignment: FractionalOffset(0.98, 0.99),
              child: FloatingActionButton(
                  heroTag: "botonDown",
                  child: Icon(
                    Icons.arrow_downward,
                  ),
                  elevation: 1.0,
                  onPressed: () {
                    offSetActual += 150;

                    if (offSetActual >=
                        homeController.position.maxScrollExtent) {
                      offSetActual = homeController.position.maxScrollExtent;
                    } else {
                      verBotonArriba = true;
                    }

                    _actualizar();

                    homeController.animateTo(
                      offSetActual, // change 0.0 {double offset} to corresponding widget position
                      duration: Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  }),
            ),
          ),
        ]));
  }

  // Metodo para inicializar y cargar los datos necesarios
 /* inicializar() async {
    if (Sesion.argumentos.length == 0) {
      await Sesion.db.consultarTodosUsuarios().then((e) {
        usuarios = e;
        if (usuarios.length > 10) verBotonAbajo = true;
        _actualizar();
      });
    } else if (Sesion.argumentos.first == "profesores") {
      await Sesion.db.consultarTodosProfesores().then((e) {
        usuarios = e;
        if (usuarios.length > 10) verBotonAbajo = true;
        _actualizar();
      });
    } else {
      await Sesion.db.consultarTodosAlumnos().then((e) {
        usuarios = e;
        if (usuarios.length > 10) verBotonAbajo = true;
        _actualizar();
      });
    }

    Sesion.argumentos.clear();
  }*/

  /*SeleccionUsuario() async {
    if (Sesion.metodoLogin == "free") {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => PasswordLogin()));
    }

    //inicializar();
  }*/

  // Widget para cargar las imagenes que van en los creditos
  Widget ImagenUGR() {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (imagenUgr != null) ...[
            Image.network(
              imagenUgr,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ],

        ]));
  }

  // Devuelve la lista de usuarios
  Widget ListaUsuarios() {
    if (usuarios == null)
      return Column(children: [
        Text(nombre),
        ImagenUGR(),
        Text('Créditos: Los mochileros'),
        Text(
            'Rafael Guzmán , Blanca Abril , Javier Mesa , José Paneque , Hicham Bouchemma , Emilio Vargas'
                .toUpperCase()),
        SizedBox(height: 15,),
        ElevatedButton(
          child: Container(
              width: anchoUsuarios.toDouble(),
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text(
                    "Ve al registro de Usuarios",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  /*Image.network(
                    usuarios[j].foto,
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                    errorBuilder: (context, exception, stacktrace) {
                      print(exception.toString());
                      return Image.asset('assets/desconocido.jpg',
                          width: 90, height: 90);
                    },
                  ),*/
                ],
              )),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Registro()));
          },
        )
      ]);
    else {
      return OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? buildPortrait()
            : buildLandscape(),
      );
    }
  }

  buildLandscape() {
    maxUsuariosPorFila = 4;

    while(MediaQuery.of(context).size.width<maxUsuariosPorFila*(anchoUsuarios+espacioEntreUsuarios)){
      maxUsuariosPorFila--;
    }

    return SingleChildScrollView(
        controller: homeController, child: buildLista());
  }

  buildPortrait() {
    maxUsuariosPorFila = 2;

    while(MediaQuery.of(context).size.width<maxUsuariosPorFila*(anchoUsuarios+espacioEntreUsuarios)){
      maxUsuariosPorFila--;
    }

    return SingleChildScrollView(
        controller: homeController, child: buildLista());
  }

  // Construye la lista de usuarios
  buildLista() {
    return Column(children: [
      for (int i = 0; i < usuarios.length / maxUsuariosPorFila; i++)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int j = i * maxUsuariosPorFila;
          j < (i * maxUsuariosPorFila) + maxUsuariosPorFila &&
              j < usuarios.length;
          j++)
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Container(
                      width: anchoUsuarios.toDouble(),
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                            usuarios[j].nombre.toString().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Image.network(
                            usuarios[j].foto,
                            width: 120,
                            height: 120,
                            fit: BoxFit.fill,
                            errorBuilder: (context, exception, stacktrace) {
                              print(exception.toString());
                              return Image.asset('assets/desconocido.jpg',
                                  width: 90, height: 90);
                            },
                          ),
                        ],
                      )),
                  onPressed: () {
                    /*Sesion.id = usuarios[j].id;
                    Sesion.nombre = usuarios[j].nombre;
                    Sesion.rol = usuarios[j].rol;
                    Sesion.foto = usuarios[j].foto;
                    if (usuarios[j].metodoLogeo ==
                        Passportmethod.free.toString()) {
                      Sesion.metodoLogin = "free";
                    } else {
                      Sesion.metodoLogin = usuarios[j].metodoLogeo ==
                          Passportmethod.pin.toString()
                          ? Passportmethod.pin.toString()
                          : Passportmethod.text.toString();
                    }
                    SeleccionUsuario();*/
                  },
                ))
        ]),
    ]);
  }


  // Metodo para actualizar la pagina
  void _actualizar() async {
    //maxUsuariosPorFila = MediaQuery.of(this.context).orientation == Orientation.portrait? 2 : 4;
    setState(() {});
  }
}
