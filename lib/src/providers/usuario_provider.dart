import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyD-brxvyLWp-D2UEzXjQ2doBwXREoz9Ydc';
  //instanciamos las preferencias de usuario

  //realizar el login en la aplicacion
  Future<Map<String, dynamic>> login(String email, String pass) async {
    // mapa con los datos
    final authData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };

    // hacemos la peticion al servicio
    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    //pasamos a json la respuesta de fireBase
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    // preguntamos si tiene token
    if (decodedResp.containsKey('idToken')) {
      //debemos salvar el token en el storage
      //_prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  // realiza el registro de un usuario nuevo
  Future<Map<String, dynamic>> nuevoUsuario(String email, String pass) async {
    // mapa con los datos ingresados por el usuario
    final authData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };
    // hacemos la peticion al servicio
    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    //pasamos a json la respuesta de fireBase
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    // preguntamos si tiene token
    if (decodedResp.containsKey('idToken')) {
      //debemos salvar el token en el storage
      //_prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
