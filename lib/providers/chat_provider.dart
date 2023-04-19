import 'package:chat/models/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/mensaje.dart';
import 'auth_provider.dart';

import 'package:chat/global/enviroments.dart';
import '../models/usuario.dart';

class ChatProvider extends ChangeNotifier {
  late Usuario receptor; //Usuario receptor de los mensajes del usuario logueado

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final Uri uri = Uri.parse("${Enviroments.apiUrl}mensajes/$usuarioID");
    final response = await http.get(uri, headers: {
      "content-type": "application/json",
      "x-token": await AuthProvider.getToken() ?? "-"
    });
    final mensajesReponse = mensajesReponseFromJson(response.body);
    return mensajesReponse.mensajes;
  }
}
