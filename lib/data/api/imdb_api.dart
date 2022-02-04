import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:majoomovie/data/provider/dashboard_provider.dart';

class ImdbApi {
  String endpoint = "https://imdb8.p.rapidapi.com/auto-complete?q=game of thr";
  DashboardProvider dashboardProvider = DashboardProvider.instance;

  Map<String, String> requestHeader = {
    'x-rapidapi-host': 'imdb8.p.rapidapi.com',
    'x-rapidapi-key': '6d53a700d7msh7d81f2ad5fbeb60p16aa2djsnd17a77e62fdb'
  };

  Future<Map<dynamic, dynamic>> baseClient() async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url, headers: requestHeader);
    if (response.statusCode == 200) {
      dashboardProvider.bodyValue = response.statusCode.toString();

      Map<dynamic, dynamic> body = jsonDecode(response.body);
      dashboardProvider.detail.add(body['d']);
      return body;
    }
    dashboardProvider.bodyValue = response.statusCode.toString();
    Map<dynamic, dynamic> body = {};
    return body;
  }
}
