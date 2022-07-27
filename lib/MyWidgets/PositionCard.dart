import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/CoffeObject.dart';
import '../controllers/BasketObject.dart';

class PositionCard extends StatefulWidget {
  Coffe coffe;
  PositionCard({required this.coffe, Key? key}) : super(key: key);

  @override
  State<PositionCard> createState() => _PositionCardState(coffe);
}

class _PositionCardState extends State<PositionCard> {
  Coffe coffe;
  String suppliments = '';

  _PositionCardState(this.coffe) {
    for (Property item in coffe.properties) {
      if (item.used) {
        suppliments = suppliments + item.name + ', ';
      }
    }
    if (suppliments.length > 2) {
      suppliments = suppliments.substring(0, suppliments.length - 2);
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: coffe.picture,
              width: width / 3,
            ),
            SizedBox(
                width: width - (width / 3) - 10,
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 20,
                        child: ListTile(
                          title: Text(coffe.name),
                          tileColor: Color.fromARGB(255, 218, 226, 233),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Объем ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            flex: 6,
                          ),
                          Expanded(
                            child: Text(
                              coffe.selectedVolume.volume.toString() + ' мл',
                              style: TextStyle(color: Colors.red),
                            ),
                            flex: 6,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Количество ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            flex: 6,
                          ),
                          Expanded(
                            child: Text(
                              coffe.count.toString() + ' шт',
                              style: TextStyle(color: Colors.red),
                            ),
                            flex: 6,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Добавки ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            flex: 6,
                          ),
                          Expanded(
                            child: Text(
                              suppliments,
                              style: TextStyle(color: Colors.red),
                            ),
                            flex: 6,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black),
                      Row(
                        children: [
                          Expanded(
                            child: Text(' ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            flex: 5,
                          ),
                          Expanded(
                            child: Text(
                              'Стоимость: ' + coffe.total.toString() + ' руб.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 5, 5, 5)),
                            ),
                            flex: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      top: 0,
                      right: -15,
                      child: RawMaterialButton(
                        onPressed: () {
                          Provider.of<BasketObject>(context, listen: false)
                              .removeCoffe(coffe);
                        },
                        elevation: 2.0,
                        fillColor: Colors.blue[100],
                        child: Icon(
                          Icons.close_sharp,
                          color: Colors.red,
                          size: 15.0,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      )),
                ]))
          ],
        ));
  }
}
