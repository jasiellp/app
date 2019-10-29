import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/Favorito/style.dart';
import 'package:food_ordering_app/theme/style.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/HomeWithTab');
            }),
        title: new Text(
          'Favoritos',
          style: textStylew500,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 70.0, bottom: 25.0),
              child: new CircleAvatar(
                child: new Image(image: favouritesImg),
                backgroundColor: Colors.white,
                radius: 100.0,
              ),
            ),
            const Text(
              'You dont have any favourite restaurant yet.',
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(color: Colors.black),
            ),
            const Text(
              'Mark your restaurants favourite and they will show up here!',
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
