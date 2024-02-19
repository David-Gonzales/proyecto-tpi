
import 'dart:convert';

ObtenerDetalleEvaluacionResponse obtenerDetalleEvaluacionResponseFromJson(String str) => ObtenerDetalleEvaluacionResponse.fromJson(json.decode(str));

String obtenerDetalleEvaluacionResponseToJson(ObtenerDetalleEvaluacionResponse data) => json.encode(data.toJson());

class ObtenerDetalleEvaluacionResponse {
    String nombre;
    String fecha;
    String foto;
    List<Resultado> resultado;

    ObtenerDetalleEvaluacionResponse({
        required this.nombre,
        required this.fecha,
        required this.foto,
        required this.resultado,
    });

    factory ObtenerDetalleEvaluacionResponse.fromJson(Map<String, dynamic> json) => ObtenerDetalleEvaluacionResponse(
        nombre: json["nombre"],
        fecha: json["fecha"],
        foto: json["foto"],
        resultado: List<Resultado>.from(json["resultado"].map((x) => Resultado.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "fecha": fecha,
        "foto": foto,
        "resultado": List<dynamic>.from(resultado.map((x) => x.toJson())),
    };
}

class Resultado {
    String animal;
    double probabilidad;

    Resultado({
        required this.animal,
        required this.probabilidad,
    });

    factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
        animal: json["animal"],
        probabilidad: json["probabilidad"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "animal": animal,
        "probabilidad": probabilidad,
    };
}
