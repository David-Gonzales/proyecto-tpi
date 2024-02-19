import 'dart:convert';
import 'package:app_tpi/src/model/request/evaluacionRequest.dart';
import 'package:app_tpi/src/model/response/evaluacionResponse.dart';
import 'package:app_tpi/src/model/response/obtenerEvaluacionesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:app_tpi/src/model/globals.dart' as globals;

import '../model/response/obtenerEvaluacionDetalleResponse.dart';

class EvaluacionService {
  obtenerEvaluaciones(int? idUsuario) async {
    String urlConsultas = globals.urlConsultas;
    try {
      final Map<String, dynamic> body = {
        "idUsuario": idUsuario
      };
      var url = Uri.parse('$urlConsultas/api/Evaluacion/obtenerListaEvaluaciones');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(body)
      );

      if(response.statusCode == 200){
        List<ObtenerEvaluacionesResponse> listaEvaluaciones = obtenerEvaluacionesResponseFromJson(response.body);
        return listaEvaluaciones;
      } else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }

  obtenerDetalleEvaluacion(int? idEvaluacion) async {
    String urlConsultas = globals.urlConsultas;
    try {
      final Map<String, dynamic> body = {
        "idEvaluacion": idEvaluacion
      };
      var url = Uri.parse('$urlConsultas/api/Evaluacion/obtenerDetalleEvaluacion');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(body)
      );

      if(response.statusCode == 200){
        ObtenerDetalleEvaluacionResponse detalleEvaluacion = obtenerDetalleEvaluacionResponseFromJson(response.body);
        return detalleEvaluacion;
      } else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }

  evaluacion(EvaluacionRequest evaluacionRequest) async {
    String urlConsultas = globals.urlConsultas;
    try {
      final Map<String, dynamic> body = {
        "nombreEvaluacion": evaluacionRequest.nombreEvaluacion,
        "idUsuario": evaluacionRequest.idUsuario,
        "imagen": evaluacionRequest.imagen,
      };
      var url = Uri.parse('$urlConsultas/api/Evaluacion/obtenerEvaluacion');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(body)
      );

      if(response.statusCode == 200){
        EvaluacionResponse evaluacionResponse = evaluacionResponseFromJson(response.body);
        return evaluacionResponse;
      } 
      else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }

}