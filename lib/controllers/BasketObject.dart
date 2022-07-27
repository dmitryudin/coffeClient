import 'package:coffe/controllers/OrdersObject.dart';
import 'package:flutter/cupertino.dart';
import 'CoffeObject.dart';

class BasketObject with ChangeNotifier {
  List<Coffe> coffePositions = [];
  double total = 0.0;

  

  List<Coffe> packOrder(List<Coffe> coffePositions) {
    List<Coffe> tempCoffe = [];
    for (var coffe in coffePositions) {
      int countIteration = coffe.count;
      for (int i = 0; i < countIteration; i++) {
        coffe.count = 1;
        tempCoffe.add(coffe);
      }
    }
    List<Coffe> newCoffe = [];
    void recurseAlgorithm() {
      if (!tempCoffe.isEmpty) {
        Coffe coffe = tempCoffe.first;
        int count = tempCoffe.where((item) => coffe.compareWith(item)).length;
        print('count $count');
        Coffe myCoffe = coffe.getDeepCopy();
        myCoffe.count = count;
        newCoffe.add(myCoffe);
        tempCoffe.removeWhere((element) => coffe.compareWith(element));
        recurseAlgorithm();
      } else {
        return;
      }
    }

    recurseAlgorithm();
    return newCoffe;
  }

  void addCoffe(Coffe coffe) {
    total = 0;
    coffePositions.add(coffe);
    coffePositions = packOrder(coffePositions);
    for (Coffe coffe in coffePositions) {
      total = total + coffe.getTotal();
    }
    notifyListeners();
  }

  void removeCoffe(coffe) {
    coffePositions.remove(coffe);
    notifyListeners();
  }

  BasketObject();
}
