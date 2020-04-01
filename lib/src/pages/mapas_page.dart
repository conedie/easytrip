import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class MapasPage extends StatefulWidget {
  @override
  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {
  Position _position;
  var vali;
  StreamSubscription<Position> _positionStream;
  @override
  void initState() {
    super.initState();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
    _positionStream = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _insertaMapa(),
    );
  }

  Widget _insertaMapa() {
    if (_position?.latitude == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FlutterMap(
        options: MapOptions(
          center: LatLng(_position.latitude, _position.longitude),
          zoom: 18,
        ),
        layers: [
          _crearLayers(),
          _crearMarcadores(),
        ],
      );
    }
  }

  _crearLayers() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiZWFzeXRyaXAiLCJhIjoiY2s4M3FlYWR1MDI1MzNlbGFpZXc1bzlybiJ9.h7rB6HGe7Z_MOtm6qt2JUw',
          'id': 'mapbox.streets' // streets, dark, light, outdoors, satellite
        });
  }

  _crearMarcadores() {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(_position.latitude, _position.longitude),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 45.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }
}
