import 'package:checklist_app/SQlite/db.dart';
import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {

  Future<bool> login({
    required String username,
    required String password
  }) async {

    var login = await DB.login(
      username: username,
      password: password
    );

    if(login.isEmpty) {
      return false;
    } else {
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

    debugPrint("==============");
    debugPrint(register.toString());
    debugPrint("==============");
  }

}