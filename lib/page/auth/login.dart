import 'package:checklist_app/page/auth/register.dart';
import 'package:checklist_app/page/note/note.dart';
import 'package:checklist_app/provider/auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  late TextEditingController usernameC;
  late TextEditingController passC;

  Future<void> login() async {

    if(formKey.currentState!.validate()) {
      
      bool login = await context.read<AuthNotifier>().login(
        username: usernameC.text, 
        password: passC.text
      );
      
      if(login) {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('User is invalid'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          }
        );
      }
    }

  }

  @override 
  void initState() {
    super.initState();

    usernameC = TextEditingController();
    passC = TextEditingController();
  }

  @override 
  void dispose() {
    usernameC.dispose();
    passC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text("Login",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ),
      body: RefreshIndicator.adaptive(
        color: Colors.black,
        onRefresh: () {
          return Future.sync(() {

          });
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [

            SliverPadding(
              padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 15.0,
                left: 25.0,
                right: 25.0
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        TextFormField(
                          controller: usernameC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'username cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            )
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        TextFormField(
                          controller: passC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'username cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black
                              )
                            )
                          ),
                        ),

                      ],
                    )
                  ),

                  const SizedBox(height: 25.0),

                  ElevatedButton(
                    onPressed: login,
                    child: const Text('Login',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                  ),

                  const SizedBox(height: 15.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text("Don't have an account ?",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()
                          ));
                        },
                        child: const Text("Register",
                          style: TextStyle(
                            fontSize: 12.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )

                    ],
                  )

                ])
              ),
            ),
        
          ],
        ),
      )
    );
  }
}