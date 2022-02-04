import 'package:flutter/material.dart';
import 'package:majoomovie/common/routes.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:majoomovie/data/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenProvider>(
            create: (_) => AuthenProvider.instance),
        ChangeNotifierProvider<DashboardProvider>(
            create: (_) => DashboardProvider.instance)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: onGenerateRoutes,
      ),
    );
  }
}
