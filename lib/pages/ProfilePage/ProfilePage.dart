import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe/MyWidgets/ViewEditText.dart';
import 'package:coffe/controllers/UserProfileObject.dart';
import 'package:coffe/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProfile userProfile = Provider.of<UserProfile>(context, listen: true);
    return Stack(
      children: [
        Column(children: [
          Container(
              height: height / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 0, 40, 160),
                      Color.fromARGB(255, 79, 118, 247),
                    ],
                  )),
              child: Column(children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: []),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: height * 0.18)),
                      Icon(Icons.supervised_user_circle, size: width / 3)
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Профиль пользователя",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.italic,
                            fontSize: 22,
                            color: Colors.white))
                  ],
                ),
              ])),
          Padding(padding: EdgeInsets.only(top: 200)),
          Container(
            width: width * 0.9,
            child: Column(children: [
              ViewEditText(
                data: userProfile.name,
                onChange: (String value) {},
                textType: TextInputType.name,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ViewEditText(
                data: userProfile.phone,
                onChange: (String value) {},
                textType: TextInputType.phone,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ViewEditText(
                data: userProfile.email,
                onChange: (String value) {},
                textType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Обновить профиль'))
            ]),
          ),
        ]),
        Positioned(
            top: height / 3.4,
            left: width * 0.05,
            child: Container(
                width: width * 0.9,
                child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Бонусный баланс: ",
                                style: TextStyle(),
                              ),
                              Text('${userProfile.bonuses}',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 117, 245, 121))),
                              Text(
                                "",
                                style: TextStyle(),
                              ),
                            ]),
                        Card(
                          color: Colors.white,
                          elevation: 10,
                          child: QrImage(
                            data: "1234567890",
                            version: QrVersions.auto,
                            size: width * 0.3,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        )
                      ],
                    ))))
      ],
    );
  }
}
