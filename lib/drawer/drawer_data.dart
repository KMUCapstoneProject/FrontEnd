import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawer_data{

  static final drawer_data _instance = drawer_data._internal();
  bool _login_check = false;
  String _login_rating = "normal";
  final List<Widget> _test = <Widget>[];

  drawer_data._internal(){}

  void padaggda()
  {
    _test.add(ListTile());
  }

  factory drawer_data(){
    return _instance;
  }

  void rating_change(String data) => this._login_rating;
  bool login_check() => _login_check;
  String login_rating() => _login_rating;

}