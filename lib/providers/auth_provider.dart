import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/login_response.dart';
import '../models/register_response.dart';
import '../models/usuario.dart';

import 'package:chat/global/enviroments.dart';

class AuthProvider extends ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  //Lugar donde voy a almacenar el token
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool autenticando) {
    _autenticando = autenticando;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.delete(key: "token");
  }

  Future<bool> login(String mail, String password) async {
    //Esto llama al setter, es decir, al notifylisteners
    autenticando = true;
    //Este data es igual a la respuesta del backend
    //cuando hay un login (mirar login en postman)
    final data = {"mail": mail, "password": password};

    Uri uri = Uri.parse("${Enviroments.apiUrl}login/");
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    autenticando = false;
    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future register(String nombre, String mail, String password) async {
    //Esto llama al setter, es decir, al notifylisteners
    //Este data es igual a la respuesta del backend
    //cuando hay un login (mirar login en postman)
    autenticando = true;
    final data = {"nombre": nombre, "mail": mail, "password": password};

    Uri uri = Uri.parse("${Enviroments.apiUrl}login/new");
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    autenticando = false;
    if (response.statusCode == 200) {
      final registerResponse = registerResponseFromJson(response.body);
      usuario = registerResponse.usuario;
      await _guardarToken(registerResponse.token);
      return true;
    }
    //Como el response.body es mas largo que el que sale en el curso, tengo que llegar a msg de
    //esta manera.
    return jsonDecode(response.body)["errors"]["errors"][0]["msg"];
  }

  Future<bool?> isLogged() async {
    final token = await _storage.read(key: "token");
    Uri uri = Uri.parse("${Enviroments.apiUrl}login/renew");
    try{
      final response = await http.get(
        uri,
        headers: {"x-token": token ?? "abc", "content-type": "application/json"},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final registerResponse = registerResponseFromJson(response.body);
        usuario = registerResponse.usuario;
        await _guardarToken(registerResponse.token);
        return true;
      }
      logout();
      return false;
    }catch(e){
      logout();
      return false;
    }

  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    return await _storage.delete(key: "token");
  }
}
