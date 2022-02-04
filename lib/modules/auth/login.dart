// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:majoomovie/data/database/database_handler.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:majoomovie/modules/auth/register.dart';
import 'package:majoomovie/modules/dashboard/dashboard.dart';

class LoginScreen extends StatelessWidget {
  static const routename = "/auth/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: _LoginForm()),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  DatabaseHandler handler = DatabaseHandler();
  AuthenProvider authenProvider = AuthenProvider.instance;
  String? errorText;
  bool statuslogin = false;

  onpressed() {
    String getEmail = email.value.text;
    String getPassword = password.value.text;
    setState(() {
      statuslogin = false;
    });
    if (getEmail == '' || getPassword == '') {
      errorText = "please fill your email and password";
    } else {
      setState(() {
        handler.getLogin(getEmail, getPassword);
        if (authenProvider.statusLogin == true) {
          Navigator.pushReplacementNamed(context, DashBoardScreen.routename);
          authenProvider.email = getEmail;
          print(authenProvider.statusLogin);
        } else {
          errorText = "user not found!";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("email"), errorText: statuslogin ? '' : null),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("password"),
                    errorText: statuslogin ? null : errorText),
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70, left: 70),
              child: ElevatedButton(onPressed: onpressed, child: Text("Login")),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: (() {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routename);
                }),
                child: Text("Register"),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
