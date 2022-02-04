// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:majoomovie/data/database/database_handler.dart';
import 'package:majoomovie/data/models/user.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:majoomovie/modules/auth/login.dart';
import 'package:majoomovie/modules/dashboard/dashboard.dart';

class RegisterScreen extends StatelessWidget {
  static const routename = "/auth/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: _RegisterForm()),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  __RegisterFormState createState() => __RegisterFormState();
}

class __RegisterFormState extends State<_RegisterForm> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  DatabaseHandler handler = DatabaseHandler();
  String? errorText;
  bool registerStatus = false;
  AuthenProvider authenProvider = AuthenProvider.instance;

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  Future<int> addUsers(
      String getUsername, String getEmail, String getPassword) async {
    User addusers =
        User(email: getEmail, username: getUsername, password: getPassword);
    List<User> listOfUsers = [addusers];
    print("add user success");
    return await handler.insertUser(listOfUsers);
  }

  onpressed() {
    String getUsername = username.value.text;
    String getEmail = email.value.text;
    String getPassword = password.value.text;
    print("here");
    if (getUsername == '' || getEmail == '' || getPassword == '') {
      setState(() {
        registerStatus = true;
        errorText = "something wrong";
      });
    }
    setState(() {
      handler.initializeDB().whenComplete(() async {
        await addUsers(getUsername, getEmail, getPassword);
        authenProvider.email = getEmail;
        authenProvider.statusLogin = true;
        Navigator.pushReplacementNamed(context, DashBoardScreen.routename);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("username"),
                    errorText: registerStatus ? '' : null),
                controller: username,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("email"),
                    errorText: registerStatus ? '' : null),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("password"),
                    errorText: registerStatus ? errorText : null),
                controller: password,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70, left: 70),
              child:
                  ElevatedButton(onPressed: onpressed, child: Text("Register")),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: (() {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routename);
                }),
                child: Text("Login"),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
