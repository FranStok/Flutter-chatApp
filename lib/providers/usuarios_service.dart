import 'package:chat/global/enviroments.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri=Uri.parse("${Enviroments.apiUrl}usuarios");
      final response = await http
        .get(
          uri,
          headers: {
            "content-type": "application/json",
            "x-token": await AuthProvider.getToken() ?? "-"
      });
      final usuariosResponse = usuariosResponseFromJson(response.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
