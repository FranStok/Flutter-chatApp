import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/socket_provider.dart';

import 'package:chat/alertas/alertas.dart';

import '../widgets/custom_labels.dart';
import '../widgets/custom_logo.dart';
import 'package:chat/widgets/custom_elevated_btn.dart';
import 'package:chat/widgets/custom_inputs.dart';

class RegisterPage extends StatelessWidget {
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
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Logo(titulo: "Registro"),
                  _Form(),
                  Labels(route: "login", isLogin: false),
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
  final nameCtrl = TextEditingController();
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
            icon: const Icon(Icons.perm_identity_outlined),
            text: "Nombre",
            controller: nameCtrl,
          ),
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
              text: "Crear cuenta",
              onPressed: (!authProvider.autenticando)
                  ? () async {
                      //Elimina el focus del teclaro cuando mandamos.
                      FocusScope.of(context).unfocus();
                      final registerOk = await authProvider.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passwordCtrl.text.trim());
                      if (registerOk == true) {
                        socketProvider.connect();
                        Navigator.pushReplacementNamed(context, "usuarios");
                      } else {
                        alertaCredenciales(
                            context, "${registerOk}", "Revise credenciales");
                      }
                    }
                  : null)
        ],
      ),
    );
  }
}
