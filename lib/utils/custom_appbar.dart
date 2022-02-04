// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:majoomovie/data/database/database_handler.dart';
// import 'package:majoomovie/data/provider/auth_provider.dart';
// import 'package:majoomovie/modules/auth/login.dart';

// class CustomAppbar extends StatefulWidget {
//   final String title;
//   const CustomAppbar({Key? key, required this.title}) : super(key: key);

//   @override
//   _CustomAppbarState createState() => _CustomAppbarState();
// }

// class _CustomAppbarState extends State<CustomAppbar> {
//   DatabaseHandler handler = DatabaseHandler();
//   AuthenProvider authenProvider = AuthenProvider.instance;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(widget.title),
//       actions: [
//         IconButton(
//             onPressed: (() {
//               setState(() {
//                 handler.getLogout(authenProvider.email);
//                 if (authenProvider.statusLogin == false) {
//                   Navigator.pushReplacementNamed(
//                       context, LoginScreen.routename);
//                 }
//               });
//             }),
//             icon: Icon(Icons.logout))
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomAppbar {
  final String title;

  CustomAppbar({required this.title});
  Widget customAppbar() {
    return AppBar(
      title: Text(title),
    );
  }
}
