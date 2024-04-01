import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:checklist_app/page/note/note.dart';
import 'package:checklist_app/page/auth/login.dart';

import 'package:checklist_app/provider/auth.dart';

import 'package:checklist_app/providers.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {


  late AuthNotifier authNotifier;

  @override 
  void initState() {
    super.initState();

    authNotifier = context.read<AuthNotifier>();
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: authNotifier.isLoggedIn(),
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          bool isLoggedIn = snapshot.data!;
          return isLoggedIn 
          ? const NotePage() 
          : const LoginPage();
        },
      )
    );
  }
}