import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/Buffet/data.dart';
import 'package:flutter/foundation.dart';

class ItemCardBuilder extends StatelessWidget {
  final List<HomeCardData> itemList;

  const ItemCardBuilder({this.itemList});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return (new Column(
        children: itemList.map((HomeCardData homeCardData) {
      return new Card(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              width: 5 * screenSize.width / 8.5,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image:
                                    new ExactAssetImage(homeCardData.thumbnail),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.star,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                                new Icon(
                                  Icons.star,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                                new Icon(
                                  Icons.star,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                                new Icon(
                                  Icons.star,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                                new Icon(
                                  Icons.star_border,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        padding: const EdgeInsets.all(10.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              child: new Text(
                                homeCardData.name,
                                softWrap: true,
                                style:
                                    Theme.of(context).primaryTextTheme.display1,
                              ),
                              padding: const EdgeInsets.only(bottom: 10.0),
                            ),
                            new Text(
                              homeCardData.quisine,
                              softWrap: false,
                              style: defaultTargetPlatform == TargetPlatform.iOS
                                  ? Theme.of(context).primaryTextTheme.display2
                                  : Theme.of(context).primaryTextTheme.display4,
                            ),
                            new Text(
                              homeCardData.price,
                              style: defaultTargetPlatform == TargetPlatform.iOS
                                  ? Theme.of(context).primaryTextTheme.display2
                                  : Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),

            new SizedBox(
              width: (screenSize.width) - (5 * screenSize.width / 8.5) - 8.0,
              child: new Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Padding(
                      child: new Text(homeCardData.timing,
                          softWrap: false,
                          style: Theme.of(context).primaryTextTheme.display3),
                      padding: const EdgeInsets.only(bottom: 10.0),
                    ),
                    new Text(
                      homeCardData.offer1,
                      softWrap: false,
                      style: defaultTargetPlatform == TargetPlatform.iOS
                          ? Theme.of(context).primaryTextTheme.display2
                          : Theme.of(context).primaryTextTheme.display4,
                    ),
                    new Text(
                      homeCardData.offer2,
                      softWrap: false,
                      style: defaultTargetPlatform == TargetPlatform.iOS
                          ? Theme.of(context).primaryTextTheme.display2
                          : Theme.of(context).primaryTextTheme.display4,
                    ),
                  ],
                ),
              ),
            ),

//              ],
//            ),
          ],
        ),
      );
    }).toList()));
  }
}
