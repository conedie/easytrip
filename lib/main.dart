import 'package:easytrip/src/bloc/provider.dart';
import 'package:easytrip/src/pages/historial_page.dart';
import 'package:easytrip/src/pages/home_page.dart';
import 'package:easytrip/src/pages/login_page.dart';
import 'package:easytrip/src/pages/mapas_page.dart';
import 'package:easytrip/src/pages/registro_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final prefs = new PreferenciasUsuario();
//    print(prefs.initPrefs());
    //incluimos el provider que se creo en el inheritedWidget
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'mapas': (BuildContext context) => MapasPage(),
          'historial': (BuildContext context) => HistorialPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          secondaryHeaderColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
