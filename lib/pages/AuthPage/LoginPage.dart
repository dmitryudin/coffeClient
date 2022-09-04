import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe/controllers/CoffeHouseObject.dart';
import 'package:coffe/pages/AuthPage/RegisterPage.dart';
import 'package:coffe/utils/Security/Validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/Configuration/ThemeData.dart';
import '../../utils/Security/Auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login = '';
  String password = '';
  String status = '';
  final _formKey = GlobalKey<FormState>();
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
                          MyTheme().kBackgroundColor.withOpacity(1.0),
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
              height: height,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 7, 7, 7),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0.0),
                    ],
                  )),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Text('Вход',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 26)),
                Padding(padding: EdgeInsets.only(top: height * 0.05)),
                Form(
                    key: _formKey,
                    child: Container(
                      width: width * 0.85,
                      child: Column(children: [
                        TextFormField(
                          //controller: TextEditingController()..text = dateTime,

                          //initialValue: dateTime,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.,]'))
                          ],
                          validator: (value) => Validator.isPhoneValid(value),
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
                          obscureText: true,
                          //initialValue: dateTime,
                          validator: (value) =>
                              Validator.isPasswordValid(value),
                          onChanged: (String value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.key),
                            labelText: 'Пароль',
                          ),
                        ),
                        Text(status, style: TextStyle(color: Colors.red)),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        ElevatedButton(
                            onPressed: () async {
                              _formKey.currentState!.validate();
                              status = await Auth()
                                  .logIn(login: login, password: password);
                              setState(() {});
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
                    ))
              ])),
        ]),
      ),
    ]));
  }
}
