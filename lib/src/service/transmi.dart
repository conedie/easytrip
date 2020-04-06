import 'package:easytrip/src/providers/db_provider.dart';
import 'package:easytrip/src/providers/estaciones_provider.dart';
import 'package:easytrip/src/providers/indicacines_provider.dart';
import 'package:easytrip/src/service/location.dart';
import 'package:easytrip/src/service/networking.dart';
import 'package:intl/intl.dart';

const dataTransmi =
    'https://gis.transmilenio.gov.co/arcgis/rest/services/Troncal/consulta_estaciones_troncales/MapServer/1/query?where=1%3D1&outFields=objectid,latitud_estacion,longitud_estacion,nombre_estacion&outSR=4326&f=json';
// key del mapbox
const apiKey =
    'pk.eyJ1IjoiZWFzeXRyaXAiLCJhIjoiY2s4M3FlYWR1MDI1MzNlbGFpZXc1bzlybiJ9.h7rB6HGe7Z_MOtm6qt2JUw';

class TransmiModel {
  final estacionesProvider = EstacionesProvider();
  final indicacionesProvider = IndicacionesProvider();

  Future getDataTransmi() async {
    //obtenemos la ubicacion
    Location location = Location();
    await location.getCurrentLocation();

    // obtenemos el json de las estacion de transmilenio
    List<dynamic> lista = await estacionesProvider.getEstaciones();
    //recorremos el json para consultas cual es la estacion que nos quemas mas cercana.
    var estacionNombre;
    var distanciaMaxima = 100000000000.0;
    var duracion = 0.0;
    var urlRutaMapBox = '';
    var a = 0;
    List<dynamic> indicaciones;

    var longitudMin = location.longitude - 0.025851;
    var longitudMax = location.longitude + 0.025851;

    var latitudMin = location.latitude - 0.015986;
    var latitudMam = location.latitude + 0.015986;

    for (var item in lista) {
      // validamos si por lo menos una estacion se encuentra a menos de 2 kilomreos
      if (((item.longitud_estacion <= longitudMax) &&
              (item.longitud_estacion >= longitudMin)) &&
          ((item.latitud_estacion >= latitudMin) &&
              (item.latitud_estacion <= latitudMam))) {
        urlRutaMapBox =
            'https://api.mapbox.com/directions/v5/mapbox/walking/${location.longitude}%2C${location.latitude}%3B${item.longitud_estacion}%2C${item.latitud_estacion}?alternatives=false&geometries=geojson&steps=true&language=es&access_token=$apiKey';
        NetworkHelper networkHelper = NetworkHelper('$urlRutaMapBox');
        var data = await networkHelper.getData();
        if (data['routes'][0]['distance'] < distanciaMaxima) {
          distanciaMaxima = data['routes'][0]['distance'];
          duracion = data['routes'][0]['duration'];
          estacionNombre = item.nombre_estacion;
          indicaciones = data['routes'][0]['legs'][0]['steps'];
        }
      }
      a++;
    }

    var distanciaPaso;

    if (estacionNombre != null) {
      var pasos = [
        'La estacion mas cercana es $estacionNombre,',
        'se encuentra a ${distanciaMaxima.round()} metros de tu ubicación y '
            'a ${(duracion / 60).round()} minutos caminando.',
        'A continuación las indicaciones...'
      ];

      for (var item in indicaciones) {
        distanciaPaso = item['distance'];
        pasos.add(
            'En ${distanciaPaso} metros, ${item['maneuver']['instruction']} ');
      }

      DateTime now = new DateTime.now();
      String mes = DateFormat('M').format(now);
      String dia = DateFormat('d').format(now);

      DBProvider.db
          .insertHistorico(estacionNombre, 'El día $dia, del mes $mes');

      return pasos;
    } else {
      return [];
    }
  }
}
