import 'package:app_tpi/src/pages/especie.dart';
import 'package:app_tpi/src/pages/evaluacion.dart';
import 'package:app_tpi/src/pages/home.dart';
import 'package:app_tpi/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;
class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
    var nombres = "globals.datosUsuario!.nombres";
    int _indexSeleccionado = 0;

    final List<Widget> _widgetOptions = <Widget>[
      const Text("            Familia                   Género                Especie"),
      const Evaluacion(),
      const Home()
    ];

    void _seleccionarOpcionNavegacion(int index) {
      setState((){
        _indexSeleccionado = index;
      });
    }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ECOAMIGOS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_indexSeleccionado),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                globals.listaEvaluaciones = [];
                globals.datosUsuario = null;
                globals.resultadoEvaluacion = null;
                globals.detalleEvaluacion = null;
                Navigator.of(context).pushReplacementNamed('/login');
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Especie'  
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Identificación'  
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'Historial'  
          )
        ],
        currentIndex: _indexSeleccionado,
        onTap: _seleccionarOpcionNavegacion,
      ),
    );
  }
}