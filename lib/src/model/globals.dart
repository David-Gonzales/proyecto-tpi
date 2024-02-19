library my_prj.globals;
import 'package:app_tpi/src/model/response/evaluacionResponse.dart';
import 'package:app_tpi/src/model/response/loginResponse.dart';
import 'package:app_tpi/src/model/response/obtenerEvaluacionDetalleResponse.dart';
import 'package:app_tpi/src/model/response/obtenerEvaluacionesResponse.dart';
//URL 
String urlConsultas = 'https://www.ecoamigos.somee.com';

LoginResponse? datosUsuario;
List<ObtenerEvaluacionesResponse> listaEvaluaciones = [];
ObtenerDetalleEvaluacionResponse? detalleEvaluacion;
EvaluacionResponse? resultadoEvaluacion;