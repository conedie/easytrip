import 'dart:async';

class Validators {
  //definimos los stream transformers

  final validarPass = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink) {
      if (pass.length >= 6) {
        sink.add(pass);
      } else {
        sink.addError('Mas de 6 caracteres');
      }
    },
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Email no es correcto');
      }
    },
  );
}
