import 'dart:convert';
import 'package:coffe/controllers/BasketObject.dart';
import 'package:coffe/utils/Security/Auth.dart';
import 'package:flutter/cupertino.dart';
import '../utils/Network/RestController.dart';
import 'CoffeObject.dart';

class OrderObject with ChangeNotifier {
  late BasketObject basketObject;
  int idPayment = -1;
  bool onPlace = false;
  String requiredDateTime = '';
  bool isComplete = false;
  double totalCost = 0.0;
  List<Coffe> unpackedCoffe = [];

  OrderObject();

  void sendOrder() {
    RestController().sendPostRequest(
        onComplete: ({required String data, required int statusCode}) {
          //getCoffes();
        },
        onError: ({required int statusCode}) {},
        controller: 'order',
        data: toJson(),
        accessToken: Auth().accessToken);
  }

  String toJson() {
    Map<String, dynamic> data = {};
    print(requiredDateTime.toString());
    data['id_payment'] = idPayment;
    data['order'] =
        basketObject.coffePositions.map((e) => jsonDecode(e.toJson())).toList();
    data['required_date_time'] = requiredDateTime;
    data['on_place'] = onPlace;
    data['total_cost'] = basketObject.total;

    return (jsonEncode(data));
  }

  OrderObject.fromJson(String json) {
    print(json);
    Map<String, dynamic> jsonString = jsonDecode(json);
    idPayment = jsonString['id_payment'];
    requiredDateTime = jsonString['required_date_time'];
    onPlace = jsonString['on_place'];
    totalCost = jsonString['total_cost'];
    unpackedCoffe = (jsonString['order'] as List)
        .map((item) => Coffe.fromOrderJson(jsonEncode(item)))
        .toList();
    print('----------------------------------------------------');
    print('айди платежа $idPayment');
    print('требуемое время $requiredDateTime');
    print('Итоговая стоимость $totalCost');
    print('На месте $onPlace');
  }
}
