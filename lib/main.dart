import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:checklist_app/page/auth/login.dart';

import 'package:checklist_app/providers.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage()
    );
  }

}