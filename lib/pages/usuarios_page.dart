import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';

import '../providers/socket_provider.dart';

import 'package:chat/providers/chat_provider.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/usuarios_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuariosService = UsuariosService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context);
    final Usuario usuario = authProvider.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario.nombre,
              style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.black87),
              onPressed: () {
                socketProvider.disconnect();
                Navigator.pushReplacementNamed(context, "login");
                AuthProvider.deleteToken();
              }),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketProvider.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.check_circle, color: Colors.blue[400])
                  : const Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        //Crea una ListView de widgets ListTile (Que son los usuarios),
        //serapados varios Divider(). ItemBuilder y separatorBuilder son como ciclos, se repiten
        body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _cargarUsuarios,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.blue[400]),
              waterDropColor: Colors.blue[400]!,
            ),
            child: ListViewUsuarios(usuarios: usuarios)));
  }

  _cargarUsuarios() async {
    // await Future.delayed(Duration(milliseconds: 1000));
    usuarios = await usuariosService.getUsuarios();
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class ListViewUsuarios extends StatelessWidget {
  const ListViewUsuarios({
    super.key,
    required this.usuarios,
  });

  final List<Usuario> usuarios;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (buildContext, i) =>
            _UsuarioListTile(usuario: usuarios[i]),
        separatorBuilder: (buildContext, i) => const Divider(),
        itemCount: usuarios.length);
  }
}

class _UsuarioListTile extends StatelessWidget {
  final Usuario usuario;
  const _UsuarioListTile({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.mail),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.receptor = usuario;
        Navigator.pushNamed(context, "chat");
      },
    );
  }
}
