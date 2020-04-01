import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mapas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
          )
        ],
      ),
    );
  }
}
