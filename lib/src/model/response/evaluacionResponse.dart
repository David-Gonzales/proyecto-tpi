import 'dart:convert';

EvaluacionResponse evaluacionResponseFromJson(String str) => EvaluacionResponse.fromJson(json.decode(str));

String evaluacionResponseToJson(EvaluacionResponse data) => json.encode(data.toJson());

class EvaluacionResponse {
    String nombre;
    String fecha;
    List<ResultadoEvaluacion> resultadoEvaluacion;

    EvaluacionResponse({
        required this.nombre,
        required this.fecha,
        required this.resultadoEvaluacion,
    });

    factory EvaluacionResponse.fromJson(Map<String, dynamic> json) => EvaluacionResponse(
        nombre: json["nombre"],
        fecha: json["fecha"],
        resultadoEvaluacion: List<ResultadoEvaluacion>.from(json["resultadoEvaluacion"].map((x) => ResultadoEvaluacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "fecha": fecha,
        "resultadoEvaluacion": List<dynamic>.from(resultadoEvaluacion.map((x) => x.toJson())),
    };
}

class ResultadoEvaluacion {
    double probabilidad;
    String animal;

    ResultadoEvaluacion({
        required this.probabilidad,
        required this.animal,
    });

    factory ResultadoEvaluacion.fromJson(Map<String, dynamic> json) => ResultadoEvaluacion(
        probabilidad: json["probabilidad"]?.toDouble(),
        animal: json["animal"],
    );

    Map<String, dynamic> toJson() => {
        "probabilidad": probabilidad,
        "animal": animal,
    };
}
