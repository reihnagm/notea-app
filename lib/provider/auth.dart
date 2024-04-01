import 'package:checklist_app/SQlite/db.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier with ChangeNotifier {

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<bool> login({
    required String username,
    required String password
  }) async {

    List<Map<String, dynamic>> login = await DB.login(
      username: username,
      password: password
    );

    if(login.isEmpty) {
      return false;
    } else {
      Map<String, dynamic> payload = {
        "username": username
      };

      String token = generateToken(payload);

      await saveToken(token);

      return true;
    }
  }

  Future<void> register({
    required String username, 
    required String password
  }) async {
    int? register = await DB.register(
      username: username, 
      password: password
    );
    debugPrint(register.toString());
  }

  Future<bool> isLoggedIn() async {
    String? token = await storage.read(key: "token");
    if(token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveToken(String token) async {  
    storage.write(key: "token", value: token);
  }

  String generateToken(Map<String, dynamic> payload) {
    final jwt = JWT(payload,
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );
    
    final token = jwt.sign(SecretKey('secret'));

    return token;
  }

}