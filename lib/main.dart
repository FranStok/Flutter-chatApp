import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:((context) => AuthProvider()))
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