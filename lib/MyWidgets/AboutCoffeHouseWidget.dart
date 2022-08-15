import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/HomePage/MapPage.dart';

class AboutCoffeHouseWidget extends StatelessWidget {
  CoffeHouse coffeHouse;
  AboutCoffeHouseWidget(this.coffeHouse) {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontSize = height / 50;
    // TODO: implement build
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        semanticContainer: true,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 20,
        child: Column(children: [
          ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                //  bottomRight: Radius.circular(15),
                // bottomLeft: Radius.circular(15))
              )),
              tileColor: Color.fromARGB(255, 7, 6, 6),
              title: Column(children: [
                Row(children: [
                  Text(
                    'Адрес:   ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                  Text(
                    coffeHouse.address,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: fontSize),
                  ),
                ]),
                Row(children: [
                  Text(
                    'Телефон:   ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                  Text(
                    coffeHouse.phone,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: fontSize),
                  ),
                ]),
                Row(children: [
                  Text(
                    'Email:   ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                  Text(
                    coffeHouse.email,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: fontSize),
                  ),
                ])
              ])),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: CachedNetworkImage(
                imageUrl: 'http://thefircoffe.ddns.net/place.png',
                imageBuilder: (context, imageProvider) => Container(
                  width: width - (width * 0.01),
                  height: height / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
        ]));
  }
}
