import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/WesternFoodMenu/breakfast.dart';
import 'package:food_ordering_app/screens/WesternFoodMenu/desserts.dart';
import 'package:food_ordering_app/screens/WesternFoodMenu/lunch.dart';
import 'package:food_ordering_app/theme/style.dart';

class WesternFoodMenu extends StatefulWidget {
  const WesternFoodMenu({Key key}) : super(key: key);

  @override
  _WesternFoodMenuState createState() => new _WesternFoodMenuState();
}

class _WesternFoodMenuState extends State<WesternFoodMenu>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController controller = new TabController(length: 3, vsync: this);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Western Food",
          style: textStylew500,
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/HomeWithTab");
            }),
        actions: <Widget>[
          new Padding(
            child: new Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
            ),
            padding: const EdgeInsets.only(right: 20.0),
          ),
          new Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ],
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        centerTitle: true,
        bottom: new TabBar(
          tabs: <Tab>[
            const Tab(
              text: "Breakfast",
            ),
            const Tab(
              text: "Lunch",
            ),
            const Tab(
              text: "Desserts",
            ),
          ],
          controller: controller,
          labelColor: Theme.of(context).primaryColor,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new BreakFast(),
          new Lunch(),
          new Desserts(),
        ],
        controller: controller,
      ),
    );
  }
}
