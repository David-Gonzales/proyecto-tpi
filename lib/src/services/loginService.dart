import 'dart:convert';
import 'package:app_tpi/src/model/request/loginRequest.dart';
import 'package:app_tpi/src/model/request/registroRequest.dart';
import 'package:app_tpi/src/model/response/loginResponse.dart';
import 'package:http/http.dart' as http;
import 'package:app_tpi/src/model/globals.dart' as globals;

class LoginService {
  login(LoginRequest loginRequest) async {
    String urlConsultas = globals.urlConsultas;
    try {
      final Map<String, dynamic> body = {
        "correoElectronico": loginRequest.correoElectronico,
        "clave": loginRequest.clave
      };
      var url = Uri.parse('$urlConsultas/api/Login');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(body)
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        return loginResponse;
      } else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }

  registro(RegistroRequest registroRequest) async {
    String urlConsultas = globals.urlConsultas;
    try {
      final Map<String, dynamic> body = {
        "nombres": registroRequest.nombres,
        "apellidos": registroRequest.apellidos,
        "correoElectronico": registroRequest.correoElectronico,
        "clave": registroRequest.clave
      };
      var url = Uri.parse('$urlConsultas/api/v1/Usuario');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(body)
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        return loginResponse;
      } else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }
}