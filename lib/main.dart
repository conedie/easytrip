import 'package:easytrip/src/bloc/provider.dart';
import 'package:easytrip/src/pages/historial_page.dart';
import 'package:easytrip/src/pages/home_page.dart';
import 'package:easytrip/src/pages/login_page.dart';
import 'package:easytrip/src/pages/mapas_page.dart';
import 'package:easytrip/src/pages/registro_page.dart';
import 'package:easytrip/src/providers/db_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: _isLogin(),
    );
  }

  Widget _isLogin() {
    return FutureBuilder(
      future: DBProvider.db.selectLogin('login'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ),
            ),
            color: Colors.white,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            initialRoute: (snapshot.data['valor'] == 1) ? 'home' : 'login',
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
          );
        }
      },
    );
  }
}
