import 'package:easytrip/src/service/transmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MapasPage extends StatefulWidget {
  @override
  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {
  final transmiModel = new TransmiModel();
  final flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    transmiModel.getDataTransmi();
  }

  //vista
  @override
  Widget build(BuildContext context) {
    speak(texto) async {
      await flutterTts.speak(texto);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Indicaciones'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: transmiModel.getDataTransmi(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              var lectura = '';
              for (var item in snapshot.data) {
                lectura = lectura + item + ',';
              }
              speak(lectura);
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(child: Text(snapshot.data[index])),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            }
          },
        ),
      ),
    );
  }

//  ListView(
//  padding: const EdgeInsets.all(8),
//  children: <Widget>[
//  Container(
//  height: 50,
//  color: Colors.amber[600],
//  child: const Center(child: Text('Entry A')),
//  ),
//  Container(
//  height: 50,
//  color: Colors.amber[500],
//  child: const Center(child: Text('Entry B')),
//  ),
//  Container(
//  height: 50,
//  color: Colors.amber[100],
//  child: const Center(child: Text('Entry C')),
//  ),
//  ],
//  ),

//  Widget _insertaMapa() {
//    //final estacionesProvider = EstacionesProvider();
//    //estacionesProvider.getEstaciones();
//    if (_position?.latitude == null) {
//      return Center(
//        child: CircularProgressIndicator(),
//      );
//    } else {
//      return FlutterMap(
//        options: MapOptions(
//          center: LatLng(_position.latitude, _position.longitude),
//          zoom: 18,
//        ),
//        layers: [
//          _crearLayers(),
//          _crearMarcadores(),
//        ],
//      );
//    }
//  }
//
//  _crearLayers() {
//    return TileLayerOptions(
//        urlTemplate: 'https://api.mapbox.com/v4/'
//            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
//        additionalOptions: {
//          'accessToken':
//              'pk.eyJ1IjoiZWFzeXRyaXAiLCJhIjoiY2s4M3FlYWR1MDI1MzNlbGFpZXc1bzlybiJ9.h7rB6HGe7Z_MOtm6qt2JUw',
//          'id': 'mapbox.streets' // streets, dark, light, outdoors, satellite
//        });
//  }
//
//  _crearMarcadores() {
//    return MarkerLayerOptions(markers: <Marker>[
//      Marker(
//          width: 100.0,
//          height: 100.0,
//          point: LatLng(_position.latitude, _position.longitude),
//          builder: (context) => Container(
//                child: Icon(
//                  Icons.location_on,
//                  size: 45.0,
//                  color: Theme.of(context).primaryColor,
//                ),
//              ))
//    ]);
//  }
}
