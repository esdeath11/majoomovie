// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:majoomovie/data/provider/dashboard_provider.dart';

class CustomUtils extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String year, series, actors;

  CustomUtils({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.year,
    required this.series,
    required this.actors,
  }) : super(key: key);
  DashboardProvider dashboardProvider = DashboardProvider.instance;
  @override
  Widget build(BuildContext context) {
    List detailName = ["Year", "Series", "Actors"];
    List<String> detailCode = ['y', 'q', 's'];

    return AlertDialog(
      title: Center(child: Text(title)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Image.network(imageUrl)),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 40,
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Expanded(child: Text('year')),
                // ignore: prefer_const_constructors
                Expanded(child: Text(year.toString()))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Expanded(child: Text('Series')),
                // ignore: prefer_const_constructors
                Expanded(child: Text(series))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Expanded(child: Text('Actors')),
                // ignore: prefer_const_constructors
                Expanded(child: Text(actors))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
