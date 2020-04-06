import 'package:easytrip/src/bloc/provider.dart';
import 'package:easytrip/src/pages/historial_page.dart';
import 'package:easytrip/src/pages/mapas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterTts = FlutterTts();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    stop() async {
      await flutterTts.stop();
    }

    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.notifications_off,
        ),
        onPressed: () => stop(),
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return HistorialPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigatorBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
            size: 80.0,
          ),
          title: Text('Indicacionés'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.brightness_5,
            size: 80.0,
          ),
          title: Text('Historico'),
        ),
      ],
    );
  }
}
