import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final bool isLogin;

  const Labels({super.key, required this.route, this.isLogin = true});

  @override
  Widget build(BuildContext context) {
    final subText = isLogin ? "¿No tiene cuenta?" : "¿Ya tiene cuenta?";
    final text = isLogin ? "¡Crea una cuenta ahora!" : "¡Ingresa ahora mismo!";

    return Column(
      children: [
         Text(subText,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),
        GestureDetector(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}
