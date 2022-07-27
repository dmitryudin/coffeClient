import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserProfile extends ChangeNotifier {
  int id = -1;
  String name = '';
  String email = '';
  String phone = '';
  String qrUrl = '';
  double bonuses = 0.0;

  String toJson() {
    Map<String, String> data = {};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return jsonEncode(data);
  }

  fromJson(var data) {
    Map<String, dynamic> jsonString = jsonDecode(data);
    name = jsonString['name'];
    phone = jsonString['phone'];
    email = jsonString['email'];
  }
}
