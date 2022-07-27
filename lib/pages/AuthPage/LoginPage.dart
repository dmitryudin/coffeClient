import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe/controllers/CoffeHouseObject.dart';
import 'package:coffe/pages/AuthPage/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/Security/Auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          expandedHeight: height / 3,
          flexibleSpace: Stack(children: [
            Positioned(
                child: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl:
                          'https://gorodskoyportal.ru/voronezh/pictures/places/39539/39539.jpg?1580901661'),
                ),
                top: 0,
                left: 0,
                right: 0,
                bottom: 0),
            Positioned(
                child: FlexibleSpaceBar(
                    title: Text(''),
                    background: Container(
                      height: height / 2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 8, 8, 8).withOpacity(0.0),
                          Color.fromARGB(255, 238, 237, 237).withOpacity(1.0),
                        ],
                      )),
                    )),
                top: 30,
                left: 0,
                right: 0,
                bottom: 0),
          ])),
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
              width: width,
              height: height - height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 238, 237, 237).withOpacity(1.0),
                      Color.fromARGB(255, 255, 255, 255).withOpacity(1.0),
                    ],
                  )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Вход',
                        style: TextStyle(color: Colors.black, fontSize: 26)),
                    Padding(padding: EdgeInsets.only(top: height * 0.05)),
                    Container(
                      width: width * 0.85,
                      child: Column(children: [
                        TextFormField(
                          //controller: TextEditingController()..text = dateTime,

                          //initialValue: dateTime,
                          validator: (value) {},
                          onChanged: (String value) {
                            login = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Телефон',
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        TextFormField(
                          //controller: TextEditingController()..text = dateTime,

                          //initialValue: dateTime,
                          validator: (value) {},
                          onChanged: (String value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.key),
                            labelText: 'Пароль',
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        ElevatedButton(
                            onPressed: () {
                              Auth().logIn(login: login, password: password);
                            },
                            child: Text('Войти')),
                        Padding(padding: EdgeInsets.only(top: height * 0.02)),
                        TextButton(
                          child: Text('Зарегестрироваться'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RegisterDialog();
                              },
                            );
                          },
                        )
                      ]),
                    )
                  ])),
        ]),
      ),
    ]));
  }
}
