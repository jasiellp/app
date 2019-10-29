import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcompanhamentoPedido extends StatefulWidget {
  @override
  _AcompanhamentoPedidoState createState() => _AcompanhamentoPedidoState();
}

class _AcompanhamentoPedidoState extends State<AcompanhamentoPedido> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
//    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        title: new Text(
          "ACOMPANHE SEU PEDIDO",
          style: new TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('pedidos')
              .document(args)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );

            int status = snapshot.data.data['status'] != null
                ? snapshot.data.data['status']['status_id']
                : 0;
            var endereco = snapshot.data.data['endereco_entrega'];
            return ListView(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Código do pedido: ${snapshot.data.documentID}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Status do Pedido:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildCircle("1", "Preparação", status, 0),
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("2", "Saiu para entrega", status, 1),
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("3", "Entregue", status, 2),
                            ],
                          )
                        ],
                      )),
                ),
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "ENTREGAR EM",
                          style: new TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              endereco['endereco'] +
                                  ',' +
                                  endereco['numero'] +
                                  ' \n' +
                                  endereco['bairro'] +
                                  '\n' +
                                  endereco['cep'],
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "PREVISÃO DE ENTREGA",
                          style: new TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${new DateFormat("HH:mm").format(snapshot.data.data['data_criado'].toDate().add(Duration(minutes: 20)))} "
                                  "- ${new DateFormat("HH:mm").format(snapshot.data.data['data_criado'].toDate().add(Duration(minutes: 30)))}",
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "DETALHES DO PEDIDO",
                          style: new TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "CPF/CNPJ na Nota?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            Text(
                              snapshot.data["cpf_cnpj"].isEmpty ? "Não" : "Sim",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                              child: Text(snapshot.data["cpf_cnpj"].isEmpty ? "" : snapshot.data["cpf_cnpj"],
                                textAlign: TextAlign.end,
                                style: TextStyle(color:Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                            )
                          ],),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Forma de Pagamento",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${snapshot.data["comanda"]["forma_pagamento"]["descricao"]}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _buildDetalhePedidoText(snapshot.data),
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                //${new NumberFormat("###.00#", "pt_BR").format(snapshot.data["comanda"]["total"])}
                                "R\$ ${new NumberFormat("###.00#", "pt_BR").format(snapshot.data["comanda"]["total"])}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  String _buildDetalhePedidoText(DocumentSnapshot snapshot) {
    String text = "\n";
    for (LinkedHashMap p in snapshot.data["comanda"]["buffet"]) {
      text += "${p["quantidade"]} x ${p["nome"].toUpperCase()} \n";
    }
    for (LinkedHashMap p in snapshot.data["comanda"]["itens"]) {
      text += "${p["quantidade"]} x ${p["nome"].toUpperCase()} \n";
    }
    return text;
  }

  //onde é criado os status do pedido
  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.red;
      //Colocando um circulo em sima do outro
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.red;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    //animação final do circulo
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }

  Widget pratosItens(data) {}
}
