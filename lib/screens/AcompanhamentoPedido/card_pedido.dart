import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardPedido extends StatelessWidget {

  final DocumentSnapshot pedido;
  final int posicao;

  CardPedido(this.pedido,this.posicao);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(pedido.documentID),
//          initiallyExpanded: pedido.data['status']['status_id'] == 0,  //todos pedidos no status inicial
          initiallyExpanded: posicao == 0,
          title: Text(
            "#${pedido.documentID.substring(pedido.documentID.length - 7, pedido.documentID.length)} - "
                "${pedido.data["status"]["status"]}",
            style: TextStyle(color: pedido.data["status"]["status_id"] != 4 ? Colors.grey[850] : Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("Total: R\$${pedido.data["comanda"]["total"].toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w500),)
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: pedido.data["comanda"]["buffet"].map<Widget>((p){
                      return ListTile(
                        title: Text(p["nome"]),
                        subtitle: Text("${p["peso"].toString()} g"),
                        trailing: Text(
                          "${p["quantidade"].toString()}",
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context)
                              .pushNamed('/AcompanhamentoPedido',arguments: pedido.documentID);

                        },
                        textColor: Colors.red,
                        child: Container(
                          child: Text("Detalhes",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14.0),
                          ),
                          width: screenSize.width - 150,
                          height: 45.0,
                          alignment: FractionalOffset.center,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
