import 'package:flutter/material.dart';

class SearchBarBuilder extends StatelessWidget {
  FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 60.0,
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new SizedBox(
            width: screenSize.width - 90.0,
            child: new Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: new DecoratedBox(
                decoration: new BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: new Container(
                  height: 40.0,
                  padding: const EdgeInsets.only(left: 5.0),
                  child: new Center(
                    child: new TextField(
                      focusNode: _focusNode,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
//                        inputFormatters: ,
                      decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Procure seu item de seu prato",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          new Align(
            alignment: Alignment.centerLeft,
            child: new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/Filter");
              },
              child: new Text(
                "Filtro",
                style: new TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
