// TODO можно в будущем сделать категории подгружаемыми с интернета

import 'package:coffe/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterDialog extends StatefulWidget {
  RegisterDialog();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterDialogState();
  }
}

class RegisterDialogState extends State<RegisterDialog> {
  String name = '';
  String phone = '';
  String email = '';
  String password = '';
  String status = '';
  RegisterDialogState() {}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        title: Text('Регистрация'),
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
            width: width,
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_add),
                      labelText: 'Имя',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  TextFormField(
                    //controller: TextEditingController()..text = dateTime,
                    //initialValue: dateTime,
                    validator: (value) {},
                    onChanged: (String value) {
                      phone = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Телефон (используется для входа в систему)',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  TextFormField(
                    //controller: TextEditingController()..text = dateTime,
                    readOnly: true,
                    //initialValue: dateTime,
                    validator: (value) {},
                    onChanged: (String value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
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
                  Text(
                    status,
                    style: TextStyle(color: Colors.red),
                  ),
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  ElevatedButton(
                      onPressed: () {
                        String data =
                            '{"name":"$name", "phone":"$phone", "email":"$email", "password":"$password", "role":"client"}';
                        print(data);
                        print('yes');
                        RestController().sendPostRequest(
                            onComplete: (
                                {required String data,
                                required int statusCode}) {
                              print(statusCode);
                              Navigator.pop(context);
                            },
                            onError: ({required int statusCode}) {
                              if (statusCode == 500) {
                                status = 'Введены некорректные данные';
                              }

                              if (statusCode == 409) {
                                status = 'Пользователь существует';
                              }
                              this.setState(() {});
                            },
                            controller: 'client',
                            data: data);
                      },
                      child: Text('Зарегестрироваться')),
                  Padding(padding: EdgeInsets.only(top: height * 0.05)),
                  TextButton(
                    child: Text(
                      'Отмена',
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ])));

    // TODO: implement build
  }
}
