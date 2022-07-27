import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Property {
  Property() {}
  double price = 0.0;
  String name = '';
  bool initialValue = false;
  late var used;
  bool selected = false;

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    String json = jsonEncode(data);
    return json;
  }

  Property.fromJsonString({jsonString}) {
    name = jsonString['name'];
    price = jsonString['price'];
    used = false;
  }
}

class Volume {
  Volume();
  double volume = 0;
  double price = 0;
  Volume.fromJsonString({jsonString}) {
    volume = jsonString['volume'];
    price = jsonString['price'];
  }
  String toJson() {
    Map<String, dynamic> data = {};
    data['volume'] = volume;
    data['price'] = price;
    String json = jsonEncode(data);
    return json;
  }
}

class Coffe with ChangeNotifier {
  Coffe();
  int id = -1;
  String category = '';
  String picture = '';
  String name = '';
  double total = 0.0;
  int count = 1;
  String description = '';
  List<Volume> priceOfVolume = [];
  List<Property> properties = [];
  late Volume selectedVolume;

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['count'] = count;
    //data['picture'] = picture;
    //data['description'] = description;
    //data['category'] = category;
    data['selected_volume'] = (selectedVolume.volume).toString();
    data['price'] = total;
    data['properties'] = properties.map((Property e) {
      if (e.used) return jsonDecode(e.toJson());
    }).toList();
    String json = jsonEncode(data);

    return json;
  }

  Coffe.fromJson(var data) {
    Map<String, dynamic> jsonString = jsonDecode(data);
    name = jsonString['name'];
    id = jsonString['id'];
    description = jsonString['description'];
    category = jsonString['category'];
    if (!jsonString['photo'].isEmpty) picture = jsonString['photo'].last;
    for (var el in jsonString['volumes'])
      this.priceOfVolume.add(Volume.fromJsonString(jsonString: el));
    for (var el in jsonString['suppliments'])
      this.properties.add(Property.fromJsonString(jsonString: el));
  }

  Coffe getDeepCopy() {
    Coffe deepCoffeCopy = Coffe();
    deepCoffeCopy.id = this.id;
    deepCoffeCopy.category = this.category;
    deepCoffeCopy.picture = this.picture;
    deepCoffeCopy.name = this.name;
    deepCoffeCopy.count = int.parse(this.count.toString());
    deepCoffeCopy.description = this.description;
    deepCoffeCopy.priceOfVolume = this.priceOfVolume;
    deepCoffeCopy.properties = this.properties;
    deepCoffeCopy.selectedVolume = this.selectedVolume;
    return deepCoffeCopy;
  }

  bool compareLists(List list1, list2) {
    if (list1.length == list2.length) {
      for (int i = 0; i < list1.length; i++) {
        if ((list1[i].name != list2[i].name) ||
            (list1[i].used != list2[i].used)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool compareWith(Coffe template) {
    return (template.id == this.id &&
        template.category == this.category &&
        template.picture == this.picture &&
        template.name == this.name &&
        template.count == int.parse(this.count.toString()) &&
        template.description == this.description &&
        template.priceOfVolume.toString() == this.priceOfVolume.toString() &&
        compareLists(template.properties, this.properties) &&
        template.selectedVolume.volume == this.selectedVolume.volume);
  }

  double getTotal() {
    double counter = 0.0;
    counter = counter + this.selectedVolume.price;
    for (Property item in this.properties) {
      if (item.used) counter = counter + item.price;
    }
    counter = counter * this.count;
    total = counter;
    return counter;
  }
}
