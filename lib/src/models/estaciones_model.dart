class Estaciones {
  List<Estacion> itemsEstaciones = new List();

  Estaciones();

  Estaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final estacion = new Estacion.fromJsonMap(item['attributes']);
      itemsEstaciones.add(estacion);
    }
  }
}

class Estacion {
  double latitud_estacion;
  double longitud_estacion;
  String nombre_estacion;

  Estacion({
    this.latitud_estacion,
    this.longitud_estacion,
    this.nombre_estacion,
  });

  Estacion.fromJsonMap(Map<String, dynamic> json) {
    latitud_estacion = json['latitud_estacion'];
    longitud_estacion = json['longitud_estacion'];
    nombre_estacion = json['nombre_estacion'];
  }
}
