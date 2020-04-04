import 'package:easytrip/src/providers/db_provider.dart';
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
  var cargarLista = false;

  speak(texto) async {
    await flutterTts.speak(texto);
  }

  stop() async {
    await flutterTts.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stop();
  }

  //vista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indicaciones'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => _cerrarSesion(),
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
      future: transmiModel.getDataTransmi(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          speak('Estamos identificando la estacion mas cercana');
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
            ),
          );
        } else {
          var lectura = '';
          for (var item in snapshot.data) {
            lectura = lectura + item + ',';
          }
          if (!cargarLista) {
            speak(lectura);
            cargarLista = true;
          }
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
    );
  }

  _cerrarSesion() {
    var dataClose = new Map<String, dynamic>();
    dataClose.addAll({'descripcion': 'login'});
    dataClose.addAll({'valor': 0});

    DBProvider.db.updateLoginTwo(dataClose);
    Navigator.pushReplacementNamed(context, 'login');
  }
}
