import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/providers/auth_provider.dart';

import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/pages/login_page.dart';


class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final autenticado = await authProvider.isLogged();
    if (autenticado!) {
      //Conectar al socket server
      //Navigator.pushReplacementNamed(context, "usuarios");
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_,__,___)=>UsuariosPage(),
      ));
    } else{
        Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_,__,___)=>LoginPage(),
      ));
    }
      //Navigator.pushReplacementNamed(context, "login");
  }
}
