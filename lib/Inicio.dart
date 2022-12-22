
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:preguntitas/registro.dart';

import 'firebase_options.dart';
import 'homepage.dart';

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
  final controllerISBN = TextEditingController();

  bool verBotonAbajo = false, verBotonArriba = false;

  var homeController;
  var nombre = "cargando...";



  @override
  void initState() {


    super.initState();

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
        body: ListaUsuarios(),
          );
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
        TextField(
          controller: controllerISBN,
          decoration: const InputDecoration(
          hintText: 'Introduce un nombre'
        )),
        SizedBox(height: 5,),
        ElevatedButton(
          child: Container(
          width: anchoUsuarios.toDouble(),
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        ),),onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    HomePage()));
        },),
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
