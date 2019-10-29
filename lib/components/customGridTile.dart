import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final String text;
  final DecorationImage icon;

  final String route;
  final DecorationImage image;

  final double height;
  final double width;

  const CustomGrid(
      {this.text, this.icon, this.image, this.route, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: height,
      child: new GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: new Stack(
          children: <Widget>[
            new Container(
              width: width,
              height: height,
              decoration: new BoxDecoration(
                image: image,
                borderRadius: new BorderRadius.circular(5.0),
              ),
            ),
            new Container(
              height: height,
              width: width,
              decoration: new BoxDecoration(
                color: Colors.black54,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircleAvatar(
                      child: new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: icon,
                        ),
                      ),
                      radius: 15.0,
                      backgroundColor: Colors.transparent,
                    ),
                    new Text(
                      text,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
