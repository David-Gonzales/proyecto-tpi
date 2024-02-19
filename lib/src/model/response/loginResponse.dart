class LoginResponse {
  int? id;
  String? nombres;
  String? apellidos;
  String? correoElectronico;

  LoginResponse({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correoElectronico,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    id: json["id"],
    nombres: json["nombres"],
    apellidos: json["apellidos"],
    correoElectronico: json["correoElectronico"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "nombres": nombres,
      "apellidos": apellidos,
      "correoElectronico": correoElectronico,
  };
}
