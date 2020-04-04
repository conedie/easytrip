class Indicaciones {
  List<Indicacion> items = new List();

  Indicaciones();

  Indicaciones.fromJsonList(
      nombre_estacion, distancia, duracion, List<dynamic> jsonList) {
    final fila = new Indicacion.fromJsonNormal(
        nombre_estacion, distancia, duracion, jsonList);
    items.add(fila);
  }
}

class Indicacion {
  String nombre_estacion;
  double distancia;
  double duracion;
  List<String> pasos;

  Indicacion({this.nombre_estacion, this.distancia, this.duracion, this.pasos});

  Indicacion.fromJsonNormal(nombre_estacion, distancia, duracion, json) {
    nombre_estacion = nombre_estacion;
    distancia = distancia;
    duracion = duracion;
    pasos = json['steps'].cast<dynamic>();
  }
}
