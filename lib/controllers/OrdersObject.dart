import 'dart:convert';
import 'package:coffe/controllers/BasketObject.dart';
import 'package:coffe/utils/Security/Auth.dart';
import 'package:flutter/cupertino.dart';
import '../utils/Network/RestController.dart';
import 'CoffeObject.dart';

class UnpackedProperty {
  String name = '';
  UnpackedProperty.fromJson(jsonString) {
    name = jsonString['name'];
    print('Добавка $name');
  }
}

class UnpackedCoffe {
  String name = '';
  String volume = '';
  double price = 0.0;
  int count = 0;
  List<UnpackedProperty> unpackedProperties = [];
  UnpackedCoffe.fromJson({required dynamic jsonString}) {
    name = jsonString['name'];
    volume = jsonString['selected_volume'];
    price = jsonString['price'];
    count = int.parse(jsonString['count'].toString());

    if (jsonString['properties'].toString() != '[null]')
      unpackedProperties = (jsonString['properties'] as List)
          .map((e) => UnpackedProperty.fromJson(e))
          .toList();
    print('Название напитка $name');
    print('Объем напитка $volume');
    print('Стоимость позиции $price');
  }
}

class OrderObject with ChangeNotifier {
  late BasketObject basketObject;
  int idPayment = -1;
  bool onPlace = false;
  String requiredDateTime = '';
  bool isComplete = false;
  double totalCost = 0.0;
  OrderObject();
  List<UnpackedCoffe> unpackedCoffe = [];

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
        .map((item) => UnpackedCoffe.fromJson(jsonString: item))
        .toList();
    print('----------------------------------------------------');
    print('айди платежа $idPayment');
    print('требуемое время $requiredDateTime');
    print('Итоговая стоимость $totalCost');
    print('На месте $onPlace');
  }
}
