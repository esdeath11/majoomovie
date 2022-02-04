import 'package:flutter/widgets.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider._();
  static final instance = DashboardProvider._();

  String bodyValue = '';

  String getBodyValue() => bodyValue;

  set setBodyValue(String value) {
    bodyValue = value;
    notifyListeners();
  }

  List detail = [];
  List getDetail() => detail;

  set setDetail(List value) {
    detail = value;
    notifyListeners();
  }
}
