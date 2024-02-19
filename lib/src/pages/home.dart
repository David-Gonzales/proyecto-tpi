import 'package:app_tpi/main.dart';
import 'package:app_tpi/src/model/response/obtenerEvaluacionesResponse.dart';
import 'package:app_tpi/src/services/evaluacionService.dart';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware{
  List<ObtenerEvaluacionesResponse> evaluaciones = [];

  @override
  void initState() {
    _actualizarEvaluaciones();
    super.initState();
  }
  
  // @override
  // void didChangeDependencies(){
  //   routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  //   super.didChangeDependencies();
  // }

  // @override
  // void didPopNext() {
  //   _actualizarEvaluaciones();
  //   super.didPopNext();
  // }

  void _actualizarEvaluaciones() async {
    setState(() {
      evaluaciones = globals.listaEvaluaciones;
    });
  }

  @override
  Widget build(BuildContext context) {    
      return SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var item in evaluaciones)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: Column(
                    children: [ListTile(
                      title: Text(item.fecha.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: const AssetImage('assets/carga.gif'), 
                        image: NetworkImage(item.nombre.toString()), width: 250, height: 250, fit: BoxFit.cover
                      ),
                      onTap: () async {
                        globals.detalleEvaluacion = await EvaluacionService().obtenerDetalleEvaluacion(item.idEvaluacion); 
                        Navigator.of(context).pushNamed('/detalleEvaluacion');
                      },
                    ),
                    const Divider(height: 2),
                    ]
                  ),
                ),
              ),
            if(evaluaciones.isEmpty)
              Center(
                heightFactor: MediaQuery.of(context).size.height * 0.02,
                child: const Text('No has realizado evaluaciones', style: TextStyle(fontSize: 18),),
              ),
          ],
        )
      );
  }
}
