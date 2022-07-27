import 'dart:async';
import 'package:coffe/pages/Orders/MessagePage.dart';
import 'package:coffe/utils/ChatEngine/ChatController.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/ChatEngine/ChatModel.dart';

class Orders extends StatefulWidget {
  @override
  MyWidget createState() {
    return MyWidget();
  }
}

late ChatModel? chatModel;

List<Widget> friendsWidget = [];

class MyWidget extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ChatController>(context, listen: true).getChatModel() !=
        null) {
      chatModel =
          Provider.of<ChatController>(context, listen: true).getChatModel();
    }
    friendsWidget = [];
    for (var item in chatModel!.abonents) {
      friendsWidget.add(Card(
        child: Text(item.login),
      ));
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text('Список абонентов')),
        body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<ChatController>(context, listen: false)
                          .addContact('login', 'name');
                    },
                    child: Text('Добавить')),
              ],
            )));
  }
}
