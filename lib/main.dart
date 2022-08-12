import 'package:coffe/controllers/OrdersObject.dart';
import 'package:coffe/controllers/UserProfileObject.dart';
import 'package:coffe/pages/AuthPage/LoginPage.dart';
import 'package:coffe/pages/ProfilePage/ProfilePage.dart';
import 'package:coffe/utils/ChatEngine/ChatController.dart';
import 'package:coffe/utils/ChatEngine/ChatModel.dart';
import 'package:coffe/utils/Configuration/ThemeData.dart';
import 'package:coffe/utils/Security/Auth.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/pages/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/CoffeHouseObject.dart';
import 'controllers/BasketObject.dart';
import '/pages/Orders/Orders.dart';
import '/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/HomePage/HomePage.dart';
import 'pages/BasketPage/BasketPage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(AbonentAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = LoginPage();
  _MyAppState() {
    Auth().init(
        authUrl: 'http://thefircoffe.ddns.net:5050/security/auth',
        refreshTokenUrl: 'http://thefircoffe.ddns.net:5050/security/refresh',
        callback: ({required bool isAuthFlag}) {
          if (isAuthFlag)
            page = MainPage();
          else
            page = LoginPage();
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(MyTheme.mySystemTheme);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CoffeHouse()),
          ChangeNotifierProvider(create: (context) => BasketObject()),
          ChangeNotifierProvider(create: (context) => ChatController()),
          ChangeNotifierProvider(create: (context) => OrderObject()),
          ChangeNotifierProvider(create: (context) => UserProfile())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: MyTheme().basicTheme(),
          home: page,
        ));
  }
}

class MainPage extends StatefulWidget {
  @override
  MyWidget createState() {
    return MyWidget();
  }
}

class MyWidget extends State {
  void _onItemTapped(ind) {
    setState(() {
      switch (ind) {
        case 0:
          Provider.of<CoffeHouse>(context, listen: false).getMainData();
          break;
        case 2:
          //Provider.of<CoffeHouse>(context, listen: false).getMainData();
          break;
        case 3:
          Provider.of<UserProfile>(context, listen: false).requestUserData();
          break;
      }

      index = ind;
    });
  }

  int index = 0;
  List<Widget> Screens = [HomePage(), BasketPage(), Orders(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Center(child: Screens[index]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        currentIndex: index,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Мои заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
