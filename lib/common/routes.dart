// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:majoomovie/modules/auth/login.dart';
import 'package:majoomovie/modules/auth/register.dart';
import 'package:majoomovie/modules/dashboard/dashboard.dart';

Route? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routename:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case RegisterScreen.routename:
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    case DashBoardScreen.routename:
      return MaterialPageRoute(builder: (_) => DashBoardScreen());
    default:
      return MaterialPageRoute(builder: (_) => LoginScreen());
  }
}
