import 'package:easytrip/src/models/indicaciones_model.dart';

class IndicacionesProvider {
  Future<List<Indicacion>> getIndicaciones(
      nombre_estacion, distancia, duracion, jsonList) async {
    final indicaciones = new Indicaciones.fromJsonList(
        nombre_estacion, distancia, duracion, jsonList);
    print(indicaciones.items[0].duracion);
    return indicaciones.items;
  }
}
