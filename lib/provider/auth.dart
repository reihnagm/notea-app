import 'package:checklist_app/SQlite/db.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier with ChangeNotifier {

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
    // int? register = await DB.register(
    //   username: username, 
    //   password: password
    // );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token") != null 
    ? true 
    : false;
  }

  Future<void> saveToken(String token) async {  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }

  String generateToken(Map<String, dynamic> payload) {
    final jwt = JWT(payload,
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );
      
    final token = jwt.sign(SecretKey('secret'));

    return token;
  }

}