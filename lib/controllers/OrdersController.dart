import 'dart:async';
import 'dart:convert';

import 'package:coffe/controllers/OrdersObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../utils/Network/RestController.dart';
import '../utils/Security/Auth.dart';

class OrderController with ChangeNotifier {
  late IO.Socket socket;
  List<OrderObject> activeOrders = [];
  void periodicUpdate() {
    Timer(Duration(milliseconds: 30 * 1000), () async {
      getActiveOrders();
      periodicUpdate();
    });
  }

  OrderController() {
    periodicUpdate();
  }
  void getActiveOrders() {
    notifyListeners();
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          List<dynamic> json = jsonDecode(data);
          activeOrders =
              json.map((e) => OrderObject.fromJson(jsonEncode(e))).toList();

          print('updated');
          notifyListeners();
        },
        onError: ({required int statusCode}) {
          notifyListeners();
        },
        controller: 'active_orders',
        data: '?user_id=${Auth().id}');
    notifyListeners();
  }

  /// chatModel = box.get('abonents');
}
