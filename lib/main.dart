import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/providers/chat_provider.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/socket_provider.dart';

import 'package:chat/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:((context) => AuthProvider())),
        ChangeNotifierProvider(create:((context) => SocketProvider())),
        ChangeNotifierProvider(create:((context) => ChatProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: "loading",
        routes: appRoutes
      ),
    );
  }
}