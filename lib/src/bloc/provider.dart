import 'package:easytrip/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

export 'package:easytrip/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  //instancia actual
  static Provider _instancia;

  // validamos si necesito una nueva instancia de la clase o se puede usar la que ya tenemos
  factory Provider({Key key, Widget child}) {
    //validamos si la instancia es nula
    if (_instancia == null) {
      //definimos la instacia con un contructor privado para que no puede ser accedida desde afuera
      _instancia = new Provider._internal(key: key, child: child);
    }
    // retorna la instancia
    return _instancia;
  }

  //contructor privado
  // key = a el id del widget
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  // Instanciamos el login bloc
  final loginBloc = LoginBloc();

  // notificar a todos los hijos true
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // debemos saber como esta el estado de mi login bloc
  // mtodo estatifo llamado of, recibe el conext que es igual al arbol de widget
  // esta funcion busca dentro del arbol de context, retorna la instacia loginbloc dentro de conexto
  static LoginBloc of(BuildContext context) {
    //busca en el contexto la instancoa del provider,
    // se especifica que retor un provider
    // en pocas palabras a buscar en el arbol yn widget = a que buscamos en Provider
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
