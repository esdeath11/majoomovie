// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:majoomovie/data/api/imdb_api.dart';
import 'package:majoomovie/data/database/database_handler.dart';
import 'package:majoomovie/data/models/user.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:majoomovie/data/provider/dashboard_provider.dart';
import 'package:majoomovie/modules/auth/login.dart';
import 'package:majoomovie/utils/custom.dart';

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
  DashboardProvider dashboardProvider = DashboardProvider.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: (() {
                setState(() {
                  handler.initializeDB().whenComplete(() {
                    handler.getLogout(authenProvider.email).whenComplete(() {
                      if (authenProvider.statusLogin == false) {
                        authenProvider.removeAll();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Logout Success")));
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routename);
                      }
                    });
                  });
                });
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<Map<dynamic, dynamic>>(
        future: ImdbApi().baseClient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var result = snapshot.data;
              print(dashboardProvider.detail);
              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    for (var i = 0; i < result!['d'].length; i++)
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (() => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomUtils(
                                        title: result['d'][i]['l'],
                                        imageUrl: result['d'][i]['i']
                                            ['imageUrl'],
                                        year: result['d'][i]['y'].toString(),
                                        actors: result['d'][i]['s'],
                                        series: result['d'][i]['q'],
                                      ))),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.7,
                                child: Image.network(
                                  result['d'][i]['i']['imageUrl'],
                                  fit: BoxFit.fill,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(result['d'][i]['l'])
                          ],
                        ),
                      )
                  ]))
                ],
              );
            }
            return Center(
              child: Center(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("something wrong! no data or no internet connection"),
                    ElevatedButton(
                        onPressed: (() => setState(() {})),
                        child: Text("reload"))
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
