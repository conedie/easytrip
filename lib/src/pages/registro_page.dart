import 'package:easytrip/src/bloc/provider.dart';
import 'package:easytrip/src/providers/usuario_provider.dart';
import 'package:easytrip/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  //creamos el cuadro de login formulario
  Widget _loginForm(BuildContext context) {
    //implementamos el patron bloc, por lo tanto se tiene acceso a todos los metos del bloc
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    // retorna  un elemento que permite hacer el scroll dependiente del alto de hijo
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // garantizamos el area de la parte superior.
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPass(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBtn(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Ya tienes cuenta? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  // creamos el campo del email
  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Theme.of(context).primaryColor,
              ),
              hintText: 'Ejemplo@correo.com',
              labelText: 'Correo electronico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  // creamos campo de contraseña
  Widget _crearPass(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).primaryColor,
              ),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePass,
          ),
        );
      },
    );
  }

  // creamos btn de logear
  Widget _crearBtn(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 15.0,
            ),
            child: Text('Registrarme'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.pass);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }

  //creamos Wigget que nos crea el fondo
  Widget _crearFondo(BuildContext context) {
    //obtener 40% de la pantalla usamos un mediaQuery
    final size = MediaQuery.of(context).size;
    final fondoSuperior = Container(
      // 40% de la pantalla altura
      height: size.height * 0.4,
      // 100% de la pantalla de ancho
      width: double.infinity,
      // gradiente
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor,
      ])),
    );

    //creamos los circulo
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    // creamos el stack para poder poner decoracion dentro del fondo superior
    return Stack(
      children: <Widget>[
        // incluimos el fondo superior
        fondoSuperior,
        Positioned(top: 90, left: 30.0, child: circulo),
        Positioned(top: -40, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        // ubicamos el icono con el nombre de la app
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_add,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'EASY TRIP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
