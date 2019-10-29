import 'package:flutter/material.dart';
import 'package:food_ordering_app/model/food.dart';
import 'dart:math' as math;

class FoodImage extends StatelessWidget {
  FoodImage({this.food});
  final MapEntry food;

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.topCenter,
      child:  new GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onTap: () =>
//            Routes.navigateTo(
//              context,
//              '/detail/${food.id}',
//            ),
        child: new Hero(
          tag: 'icon-${food.key}',
          child: new InkWell(
            onTap: (){
              showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(food.value["nome"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    Text(food.value["descricao"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),

                    ),
                    Padding(padding: EdgeInsets.all(12.0)),
                    Text("Tamanho da porção: ${food.value["peso"]}g",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ));
              });
            },
          child: Image(
            image: new AssetImage(food.value["imagem"]),
            height: 150.0,
            width: 150.0,
          )),
        ),
      ),
    );
  }
}