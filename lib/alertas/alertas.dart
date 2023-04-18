import 'package:flutter/material.dart';

alertaCredenciales(BuildContext context, String titulo, String subtitulo) {
  showDialog(
      context: context, builder: (context) => AlertDialog(
          title: Text(titulo),
          content: Text(subtitulo),
          actions: [
            MaterialButton(
              textColor: Colors.blue,
              onPressed: ()=>Navigator.pop(context),
              child: Text("Ok"),
            )         
          ],
        )
      );
}
