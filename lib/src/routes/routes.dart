import 'package:app_tpi/src/pages/detalleEvaluacion.dart';
import 'package:app_tpi/src/pages/evaluacion.dart';
import 'package:app_tpi/src/pages/inicio.dart';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/pages/home.dart';
import 'package:app_tpi/src/pages/login.dart';
import 'package:app_tpi/src/pages/registro.dart';
import 'package:app_tpi/src/pages/resultado.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => const Home(),
    '/login': (BuildContext context) => const Login(),
    '/registro': (BuildContext context) => const Registro(),
    '/detalleEvaluacion': (BuildContext context) => const DetalleEvaluacion(),
    '/evaluacion': (BuildContext context) => const Evaluacion(),
    '/resultado': (BuildContext context) => const Resultado(),
    '/inicio': (BuildContext context) => const Inicio()
  };
}
