// To parse this JSON data, do
//
//     final mensajesReponse = mensajesReponseFromJson(jsonString);

import 'dart:convert';

import 'mensaje.dart';

MensajesReponse mensajesReponseFromJson(String str) => MensajesReponse.fromJson(json.decode(str));

String mensajesReponseToJson(MensajesReponse data) => json.encode(data.toJson());

class MensajesReponse {
    MensajesReponse({
        required this.ok,
        required this.mensajes,
    });

    bool ok;
    List<Mensaje> mensajes;

    factory MensajesReponse.fromJson(Map<String, dynamic> json) => MensajesReponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}


