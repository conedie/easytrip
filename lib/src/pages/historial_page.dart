import 'package:easytrip/src/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final flutterTts = FlutterTts();
  stop() async {
    await flutterTts.stop();
  }

  speak(texto) async {
    await flutterTts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    stop();
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.volume_off,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: _crearListas(),
      ),
    );
  }

  Widget _crearListas() {
    return FutureBuilder(
      future: DBProvider.db.selectHistorial(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          //speak('Estamos identificando la estacion mas cercana');
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
            ),
          );
        } else {

          var lectura = 'Los siguientes son tus ultimos 5 destinos. ';
          var a = 1;
          for (var item in snapshot.data) {
            lectura = lectura +
                'Registro $a: estacion transmilenio ' +
                item['estacion'] +
                ', el ${item['fecha']}.';
            a++;
          }
          speak(lectura);
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[600],
                child: Center(child: Text(snapshot.data[index]['estacion'])),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }
      },
    );
  }
}
