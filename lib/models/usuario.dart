
class Usuario {
    Usuario({
        required this.nombre,
        required this.mail,
        required this.online,
        required this.uid,
    });

    String nombre;
    String mail;
    bool online;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        mail: json["mail"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "mail": mail,
        "online": online,
        "uid": uid,
    };
}