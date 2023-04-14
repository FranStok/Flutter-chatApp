import 'dart:io';
import 'package:chat/widgets/chat_messages.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb; //k IsWeb Sabe si el dispositivo es o no web.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

//TickerProviderStateMixin es para las animaciones de los mensajes.
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;

  final List<ChatMessages> _mensajes = [
    //ChatMessages(text: "hola mundo", UID: "123"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                maxRadius: 14,
                child: Text("Te",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Text("Maria",
                  style: TextStyle(color: Colors.black87, fontSize: 14))
            ],
          ),
          centerTitle: true,
          elevation: 1),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((buildContext, i) {
                return _mensajes[i];
              }),
              reverse: true,
              itemCount: _mensajes.length,
            ),
          ),
          const Divider(height: 1),
          //TODO caja de texto
          Container(
            color: Colors.white,
            height: 50,
            child: _inputChat(),
          ),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              keyboardType: TextInputType.name,
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  if (text.length > 0)
                    _estaEscribiendo = true;
                  else
                    _estaEscribiendo = false;
                });
              },
              decoration: InputDecoration.collapsed(hintText: "Enviar mensaje"),
              focusNode: _focusNode,
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              //Pregunto primero si es web, ya que la clse Platform hace fallar a la web.
              //Pregunto primero si es web, para que no se tenga que ejecutar Platform si lo es.
              child: (kIsWeb || Platform.isAndroid)
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        //Cuando onPressed es null (cuando no hay nada en la caja de texto)
                        //Entonces el voton es negrito, sino, usa este color.
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text)
                              : null,
                        ),
                      ),
                    )
                  : CupertinoButton(
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text)
                          : null,
                      child: const Text("Enviar"),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isNotEmpty) {
      final newMessage = ChatMessages(
        text: text,
        UID: "123",
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 400)),
      );
      setState(() {
        _estaEscribiendo = false;
        _mensajes.insert(0, newMessage);
        newMessage.animationController.forward();
      });
      _textController
          .clear(); //Borra el mensaje de la caja de texto cuando se manda.
      _focusNode
          .requestFocus(); //Permite que cuando se manda el mensjae, la caja de texto no se cierra.
    }
  }

  @override
  void dispose() {
    // TODO: Off del socket
    for (var mensaje in _mensajes) {
      mensaje.animationController.dispose();
    }
    super.dispose();
  }
}
