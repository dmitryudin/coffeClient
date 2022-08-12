import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe/MyWidgets/AboutWidget.dart';
import 'package:coffe/pages/HomePage/MapPage.dart';
import 'package:coffe/utils/Configuration/ThemeData.dart';
import '/MyWidgets/Carousel.dart';
import '/MyWidgets/DishView.dart';
import '/controllers/CoffeHouseObject.dart';
import '/utils/Network/RestController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Это написал я
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var coffes = Provider.of<CoffeHouse>(context, listen: true).coffes;
    List<Widget> cof = [];
    for (var coffe in coffes) {
      cof.add(DishView(coffe, key: UniqueKey()));
    }

    int i = -2;
    // TODO: implement build
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          expandedHeight: height / 3.5,
          flexibleSpace: Stack(children: [
            Positioned(
                child: FlexibleSpaceBar(
                  title: Text(
                    Provider.of<CoffeHouse>(context, listen: true).name,
                    style: MyTheme().thefirNameStyle,
                  ),
                  background: Carousel(),
                ),
                top: 0,
                left: 0,
                right: 0,
                bottom: 0),
            Positioned(
              child: Container(
                height: 20,
                //child: Card(),
                decoration: BoxDecoration(
                  color: MyTheme().kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
              ),
              bottom: 0,
              right: 0,
              left: 0,
            ),
          ])),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Align(
                alignment: Alignment.center, //or choose another Alignment
                child: SizedBox(
                    width: width - (0.01 * width),
                    child: AboutWidget(
                        Provider.of<CoffeHouse>(context, listen: true)))),
            ListView.builder(
                itemCount: (cof.length / 2).ceil().toInt(),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  i = i + 2;
                  if (cof.length - i == 1)
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [cof.last],
                    );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [cof[i], cof[i + 1]],
                  );
                })
          ],
        ),
      )
    ]);
  }
}
