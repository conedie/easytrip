import 'dart:async';

import 'package:easytrip/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

// hacemos el mixin con los validator
class LoginBloc with Validators {
  // recibe el string del campo, es BehaviorSubject para que escuche en todo momento el stream
  // las dejamos privadas paea usarlas solo en esta clase.

  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  // escuchar datos del stream
  // le pasamos el string transformer que se definido en validators
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passStream =>
      _passController.stream.transform(validarPass);

  // uso de rxDart para unir dos string para poder habilidar el boton de login
  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passStream, (e, p) => true);

  // insertamos valores al string
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  //obtenemos el ultimo valor enviado a los stream

  String get email => _emailController.value;
  String get pass => _passController.value;

  //cerramos los stream cuando no los necesitamos
  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}
