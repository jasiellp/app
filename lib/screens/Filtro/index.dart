import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/quisineCard.dart';
import 'package:food_ordering_app/screens/Filtro/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class Filter extends StatelessWidget {
  bool switch1 = true;
  bool switch2 = true;

  final DataListBuilder quisinesDataList = new DataListBuilder();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: new Container(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        child: new FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/HomeWithTab');
          },
          child: new Text(
            'APPLY FILTERS',
            style: new TextStyle(color: Colors.white),
          ),
        ),
      ),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text(
                'Dismiss',
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Text(
              'Filters',
              style: new TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            new FlatButton(
                onPressed: () {
                  showDialog<Null>(
                    context: context,
                    barrierDismissible: true, // user must tap button!
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('Consider this to reset all Filters.'),
//                      content: new SingleChildScrollView(
//                        child: new ListBody(
//                          children: <Widget>[
//                            new Text('You will never be satisfied.'),
//                            new Text('You\’re like me. I’m never satisfied.'),
//                          ],
//                        ),
//                      ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('Okay'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: new Text(
                  'Reset',
                  style: new TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  child: new Text(
                    'Sort by',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                ),
                new Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new ListTile(
                          leading: new Icon(
                            Icons.star,
                            color: const Color.fromRGBO(207, 207, 207, 1.0),
                          ),
                          title: const Text(
                            'Rating',
                            style: const TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            'High - Low',
                            style: const TextStyle(
                              color: const Color.fromRGBO(207, 207, 207, 1.0),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          decoration: new BoxDecoration(
                              border: new Border(
                                  left: new BorderSide(color: Colors.black26))),
                          child: new ListTile(
                            leading: new Icon(
                              Icons.timer,
                              color: const Color.fromRGBO(207, 207, 207, 1.0),
                            ),
                            title: const Text(
                              'Delivery Time',
                              style: const TextStyle(
                                color: const Color.fromRGBO(153, 153, 153, 1.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              'High - Low',
                              style: const TextStyle(
                                color: const Color.fromRGBO(207, 207, 207, 1.0),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  child: new Text(
                    'Cost for Two',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                ),
                new Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new ListTile(
                          leading: new Icon(
                            Icons.check_box,
                            color: const Color.fromRGBO(207, 207, 207, 1.0),
                          ),
                          title: const Text(
                            'Rs 999',
                            style: const TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            'Average',
                            style: const TextStyle(
                              color: const Color.fromRGBO(207, 207, 207, 1.0),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          decoration: new BoxDecoration(
                              border: new Border(
                                  left: new BorderSide(color: Colors.black26))),
                          child: new ListTile(
                            leading: new Icon(
                              Icons.check_box_outline_blank,
                              color: const Color.fromRGBO(207, 207, 207, 1.0),
                            ),
                            title: const Text(
                              'Rs 2000',
                              style: const TextStyle(
                                color: const Color.fromRGBO(153, 153, 153, 1.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              'Premium',
                              style: const TextStyle(
                                color: const Color.fromRGBO(207, 207, 207, 1.0),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            color: Colors.white,
          ),
          new Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  child: new Text(
                    'Restaurants with',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Expanded(
                      child: const Text(
                        'Offers',
                        style: const TextStyle(
                          color: const Color.fromRGBO(153, 153, 153, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    new Flexible(
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? (new CupertinoSwitch(
                              value: switch1,
                              onChanged: (bool val) {
                                switch1 = val;
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ))
                          : (new Switch(
                              value: switch1,
                              onChanged: (bool val) {
                                switch1 = val;
                              })),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Expanded(
                      child: const Text(
                        'Pure Veg Dishes Only',
                        style: const TextStyle(
                          color: const Color.fromRGBO(153, 153, 153, 1.0),
//                              fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    new Flexible(
                        child: new PreferredSize(
                      preferredSize: const Size(5.0, 20.0),
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? (new CupertinoSwitch(
                              value: switch2,
                              onChanged: (bool val) {
                                switch2 = val;
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ))
                          : (new Switch(
                              value: switch2,
                              onChanged: (bool val) {
                                switch2 = val;
                              })),
                    )),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  child: new Text(
                    'Quisines',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                ),
                new QuisineBuilder(
                  itemList: quisinesDataList.quisinesList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
