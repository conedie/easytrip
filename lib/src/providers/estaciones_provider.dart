import 'dart:convert';

import 'package:easytrip/src/models/estaciones_model.dart';
import 'package:http/http.dart' as http;

class EstacionesProvider {
  String url =
      'https://gis.transmilenio.gov.co/arcgis/rest/services/Troncal/consulta_estaciones_troncales/MapServer/1/query?where=1%3D1&outFields=objectid,latitud_estacion,longitud_estacion,nombre_estacion&outSR=4326&f=json';
  Future<List<Estacion>> getEstaciones() async {
    final resp = await http.get(url);
    final decodedDta = json.decode(resp.body);

    final estaciones = new Estaciones.fromJsonList(decodedDta['features']);
    return estaciones.itemsEstaciones;
  }
}
