import 'package:easytrip/src/bloc/provider.dart';
import 'package:easytrip/src/pages/historial_page.dart';
import 'package:easytrip/src/pages/mapas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.location_on,
        ),
        onPressed: () {},
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
          title: Text('Favoritos'),
        ),
      ],
    );
  }
}
