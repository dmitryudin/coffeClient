import 'package:cached_network_image/cached_network_image.dart';
import '/controllers/BasketObject.dart';
import '../MyWidgets/CounterWidget.dart';
import '/MyWidgets/AddPicture.dart';
import '/MyWidgets/DropListWrapper.dart';
import '/controllers/CoffeHouseObject.dart';
import '../controllers/CoffeObject.dart';
import '/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO можно в будущем сделать категории подгружаемыми с интернета

class SelectDishDialog extends StatefulWidget {
  Coffe coffe;

  SelectDishDialog(this.coffe);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectDishDialogState(coffe);
  }
}

class SelectDishDialogState extends State<SelectDishDialog> {
  String image = '';
  Coffe coffe;

  SelectDishDialogState(this.coffe) {
    coffe.selectedVolume = coffe.priceOfVolume[0];
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> propertiesWidget = [];
    List<Widget> volumesWidget = [];
    for (Property property in coffe.properties) {
      propertiesWidget.add(Row(children: [
        Expanded(
          child: Text(property.name),
          flex: 3,
        ),
        Text(property.price.toString()),
        Checkbox(
          value: property.used,
          onChanged: (value) {
            setState(() {
              property.used = value;
            });
          },
        ),
      ]));
    }
    for (Volume volume in coffe.priceOfVolume) {
      volumesWidget.add(Row(children: [
        Expanded(
          child: Text(volume.volume.toString()),
          flex: 3,
        ),
        Text(volume.price.toString()),
        Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
            value: volume,
            groupValue: coffe.selectedVolume,
            onChanged: (Volume? value) {
              setState(() {
                coffe.selectedVolume = value!;
              });
            }),
      ]));
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        title: Text(
          coffe.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26),
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: height * 0.9,
          width: width * 0.96,
          child: ListView(shrinkWrap: true, children: [
            Container(
                //width: width * 0.8,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
              // 666666666666665Divider(color: Colors.black),
              CachedNetworkImage(
                imageUrl: coffe.picture,
                height: height / 3,
              ),
              Divider(color: Colors.black),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Категория: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(coffe.category)
              ]),
              Divider(color: Colors.black),
              Text(
                'Выберите объем',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Expanded(
                  child: Text('Объем, мл', style: TextStyle(color: Colors.red)),
                  flex: 6,
                ),
                Expanded(
                  child: Text(
                    'Цена, руб.',
                    style: TextStyle(color: Colors.red),
                  ),
                  flex: 2,
                ),
              ]),
              Column(children: volumesWidget),
              Divider(color: Colors.black),
              Text(
                'Выберите добавки',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Expanded(
                  child: Text('Название добавки',
                      style: TextStyle(color: Colors.red)),
                  flex: 6,
                ),
                Expanded(
                  child: Text(
                    'Цена, руб.',
                    style: TextStyle(color: Colors.red),
                  ),
                  flex: 2,
                ),
              ]),
              Column(children: propertiesWidget),
              Divider(color: Colors.black),
              CounterWidget(
                onChange: ((counter) {
                  coffe.count = counter;
                }),
              ),
              Divider(color: Colors.black),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<BasketObject>(context, listen: false)
                        .addCoffe(coffe);
                    Navigator.pop(context);
                  },
                  child: Text('Добавить в корзину')),
            ]))
          ]),
        ));
    // TODO: implement build
  }
}
