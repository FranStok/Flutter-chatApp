class Mensaje {
    Mensaje({
        required this.receptor,
        required this.emisor,
        required this.mensaje,
        required this.createdAt,
        required this.updatedAt,
    });

    String receptor;
    String emisor;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        receptor: json["receptor"],
        emisor: json["emisor"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "receptor": receptor,
        "emisor": emisor,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}