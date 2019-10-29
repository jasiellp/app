import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unique_identifier/unique_identifier.dart';

class ComandaRepository {
  Future<MapEntry> getById(String id) async {
    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection('comanda').document(id).get();

    if (documentSnapshot.exists) {
      return MapEntry(documentSnapshot.documentID, documentSnapshot.data);
    }

    return MapEntry(null, null);
  }

  Future<MapEntry> get() async {
//    String identifier = await UniqueIdentifier.serial;
    String identifier = await UniqueIdentifier.serial;

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('comanda')
        //.where('data', isEqualTo: DateTime.now().toUtc())
//            .where('identifier', isEqualTo: identifier)
        .where('fechado', isEqualTo: false)
//        .orderBy('data')
        .getDocuments();

    if (querySnapshot.documents.length > 0) {
      return MapEntry(querySnapshot.documents.last.documentID,
          querySnapshot.documents.last.data);
    }

    var data = Map();
    data['total'] = 0;
    data['subtotal'] = 0;
    data['entrega'] = 0;
    data['descricao_embalagem'] = '';
    data['valor_embalagem'] = 0;
    data['peso_total'] = 0;
    data['itens'] = [];
    data['device_id'] = identifier;
    data['data'] = DateTime.now().toLocal();
    data['fechado'] = false;

    var id = await this.create(data);

    var comanda = MapEntry(id, data);

    return comanda;
  }

  Future<List<Map>> getAll() async {
    QuerySnapshot querySnapshot =
    await Firestore.instance.collection('comanda').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => x.data).toList();
    }

    return List<Map>();
  }

  Future<List<MapEntry>> getEmbalagens() async {
    QuerySnapshot querySnapshot =
    await Firestore.instance.collection('embalagens').orderBy('valor').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => MapEntry(x.documentID, x.data)).toList();
    }

    return List<MapEntry>();
  }

  Future<String> create(Map data) async {
    var reference = await Firestore.instance
        .collection('comanda')
        .add(data.cast<String, dynamic>())
        .catchError((e) {
      return e.toString();
    });

    return reference.documentID;
  }

  Future<MapEntry> update(MapEntry data) async {
    data.value['peso_total'] = 0;

    data.value['buffet'] = (data.value['buffet'] as List<MapEntry>)
        .where(
            (x) => x.value['quantidade'] != null && x.value['quantidade'] > 0)
        .map((x) {
      var prato = Map();
      prato['prato'] = x.key;
      prato['nome'] = x.value['nome'];
      prato['peso'] = x.value['peso'];
      prato['quantidade'] = x.value['quantidade'];
      prato['peso_total'] = x.value['quantidade'] * x.value['peso'];
      data.value['peso_total'] += prato['peso_total'];

      return prato;
    }).toList();

    double valor_item = 0;
    if (data.value['itens'] != null) {
      data.value['itens'].forEach((item) {
        valor_item += item['preco'] * item['quantidade'];
      });
    }
    data.value['itens'] = [];
    data.value['buffet_total'] =
        data.value['preco_kg'] * data.value['peso_total'] / 1000;
    data.value['itens_total'] = valor_item;
    data.value['subtotal'] = valor_item + data.value['buffet_total'];
    data.value['entrega'] = 10;

    var embalagens = await getEmbalagens();

//    embalagens.forEach((x){
//
//      if(data.value['peso_total'] <= x.value['peso_maximo']){
//        data.value['descricao_embalagem'] = x.value['descricao'];
//        data.value['valor_embalagem'] = x.value['valor'];
//        return;
//      }
//
//    });



    data.value['total'] = data.value['entrega'] + data.value['subtotal'];

    await Firestore.instance
        .collection('comanda')
        .document(data.key)
        .setData(data.value.cast<String, dynamic>(), merge: true)
        .catchError((error) {
      return error.toString();
    });

    return MapEntry(data.key, data.value);
  }

  Future<MapEntry> updateItem(MapEntry data) async {
    double valor_item = 0;
    data.value['itens'].forEach((item) {
      valor_item += item['preco'] * item['quantidade'];
    });
    data.value['itens_total'] = valor_item;
    data.value['subtotal'] = valor_item + data.value['buffet_total'];
    data.value['total'] = data.value['entrega'] + data.value['subtotal'];

    await Firestore.instance
        .collection('comanda')
        .document(data.key)
        .setData(data.value.cast<String, dynamic>(), merge: true)
        .catchError((error) {
      return error.toString();
    });

    return MapEntry(data.key, data.value);
  }

  Future<String> delete(String id) async {
    DocumentReference reference =
        await Firestore.instance.collection('comanda').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'deleted';
  }
}
