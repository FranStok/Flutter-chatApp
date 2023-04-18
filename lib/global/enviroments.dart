import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;


class Enviroments {
  static String apiUrl = (kIsWeb || Platform.isIOS)
    ? "http://localhost:3000/api/"
    : "http://192.168.1.44:3000/api/";
  //Referencia al server.
  static String socketUrl=(kIsWeb || Platform.isIOS)
    ? "http://localhost:3000"
    : "http://10.0.0.2:3000";
}
