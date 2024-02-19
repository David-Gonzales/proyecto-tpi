import 'dart:convert';

List<ObtenerEvaluacionesResponse> obtenerEvaluacionesResponseFromJson(String str) => List<ObtenerEvaluacionesResponse>.from(json.decode(str).map((x) => ObtenerEvaluacionesResponse.fromJson(x)));

String obtenerEvaluacionesResponseToJson(List<ObtenerEvaluacionesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ObtenerEvaluacionesResponse {
    int? idEvaluacion;
    String? nombre;
    String? fecha;

    ObtenerEvaluacionesResponse({
        required this.idEvaluacion,
        required this.nombre,
        required this.fecha,
    });

    factory ObtenerEvaluacionesResponse.fromJson(Map<String, dynamic> json) => ObtenerEvaluacionesResponse(
        idEvaluacion: json["idEvaluacion"],
        nombre: json["nombre"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "idEvaluacion": idEvaluacion,
        "nombre": nombre,
        "fecha": fecha,
    };
}
