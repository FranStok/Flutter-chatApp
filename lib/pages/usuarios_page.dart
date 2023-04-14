import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        online: true, nombre: "Maria", mail: "mail1@got", UID: "dwadwadwad"),
    Usuario(online: false, nombre: "Fran", mail: "mail2@got", UID: "qweqweqeq"),
    Usuario(
        online: false, nombre: "Emiliano", mail: "mail3@got", UID: "zxczczxcz"),
    Usuario(online: true, nombre: "Lucas", mail: "mail4@got", UID: "fghfghfhfg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text("Mi nombre", style: TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.black87),
              onPressed: () {}),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
              //child: Icon(Icons.check_offline_bolt, color: Colors.red),
            )
          ],
        ),
        //Crea una ListView de widgets ListTile (Que son los usuarios),
        //serapados varios Divider(). ItemBuilder y separatorBuilder son como ciclos, se repiten
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check,color: Colors.blue[400]),
            waterDropColor: Colors.blue[400]!,
          ),
          child: ListViewUsuarios(usuarios: usuarios)
        )
    );
  }


  _cargarUsuarios()async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
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
    );
  }
}
