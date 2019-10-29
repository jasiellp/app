import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/platform.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/theme/style.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        bottom: new PreferredSize(
            preferredSize: new Size(100.0, 70.0),
            child: BuscaCard(
                title: 'Filtrar Ajudas',
//                onChange: (item) => onChanged(item)
                )
                ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: new Text(
          "Ajuda",
          style: new TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container()
    );
  }
}
