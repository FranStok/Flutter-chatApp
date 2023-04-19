import 'package:chat/alertas/alertas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/providers/auth_provider.dart';

import 'package:chat/widgets/custom_inputs.dart';
import 'package:chat/widgets/custom_elevated_btn.dart';
import '../providers/socket_provider.dart';
import '../widgets/custom_labels.dart';
import '../widgets/custom_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        //SafeArea es un widget que nos ayuda a que los widgets esten en un lugar efectivamente
        //legibles de la pantalla, y no que esten por ejemplo arriba del menu de opciones del telefono.
        //Evita que esten arriba de las interfaces del sistema operativo.
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Logo(titulo: "Messenger"),
                  _Form(),
                  Labels(route: "register"),
                  Text("Terminos y condiciones de uso",
                      style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInputs(
            icon: const Icon(Icons.mail_outline_outlined),
            text: "Mail",
            inputType: TextInputType.emailAddress,
            controller: emailCtrl,
          ),
          CustomInputs(
            icon: const Icon(Icons.password_outlined),
            text: "Password",
            isPassword: true,
            controller: passwordCtrl,
          ),
          CustomElevatedBtn(
              text: "Login",
              onPressed: (!authProvider.autenticando)
                  ? () async {
                      //Elimina el focus del teclaro cuando mandamos.
                      FocusScope.of(context).unfocus();
                      final loginOk = await authProvider.login(
                          emailCtrl.text.trim(), passwordCtrl.text.trim());
                      if (loginOk) {
                        socketProvider.connect();
                        Navigator.pushReplacementNamed(context, "usuarios");
                      } else {
                        alertaCredenciales(
                            context, "Login incorrecto", "Revise credenciales");
                      }
                    }
                  : null)
        ],
      ),
    );
  }
}
