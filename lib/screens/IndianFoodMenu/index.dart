import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/desserts.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/mainCourse.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/starter.dart';
import 'package:food_ordering_app/theme/style.dart';
import 'package:food_ordering_app/screens/IndianFoodMenu/breakfast.dart';

class IndianFoodMenu extends StatefulWidget {
  const IndianFoodMenu({Key key}) : super(key: key);

  @override
  _IndianFoodMenuState createState() => new _IndianFoodMenuState();
}

class _IndianFoodMenuState extends State<IndianFoodMenu>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController controller = new TabController(length: 4, vsync: this);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Indian Food',
          style: textStylew500,
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/HomeWithTab');
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
              text: 'Breakfast',
            ),
            const Tab(
              text: 'Starter',
            ),
            const Tab(
              text: 'Main Course',
            ),
            const Tab(
              text: 'Desserts',
            ),
          ],
          controller: controller,
          isScrollable: true,
          labelColor: Theme.of(context).primaryColor,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new BreakFast(),
          new Starter(),
          new MainCourse(),
          new Desserts(),
        ],
        controller: controller,
      ),
    );
  }
}
