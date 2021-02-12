import 'package:flutter/material.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String level;

  UserData({
    this.uid,
    @required this.name,
    this.level,
  });
}
