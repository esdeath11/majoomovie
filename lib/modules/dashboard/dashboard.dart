// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:majoomovie/data/database/database_handler.dart';
import 'package:majoomovie/data/models/user.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:majoomovie/modules/auth/login.dart';
import 'package:majoomovie/utils/custom_appbar.dart';

class DashBoardScreen extends StatelessWidget {
  static const routename = "/dashboard";
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardWidget();
  }
}

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  DatabaseHandler handler = DatabaseHandler();
  AuthenProvider authenProvider = AuthenProvider.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: (() {
                setState(() {
                  handler.getLogout(authenProvider.email);
                  if (authenProvider.statusLogin == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Logout Success")));
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routename);
                  }
                });
              }),
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
