import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoRepository {
  Future<Map> get(String id) async {
    DocumentSnapshot querySnapshot =
        await Firestore.instance.collection('pedidos').document(id).get();

    if (querySnapshot.exists) {
      return querySnapshot.data;
    }

    return Map();
  }

  Future<List<Map>> getAll() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('pedidos').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => x.data).toList();
    }

    return List<Map>();
  }

  Future<String> create(Map data) async {

    await Firestore.instance.collection('pedidos').add(data).catchError((e) {
      print(e);
      return e.toString();
    });

    return 'create';
  }

  Future<List<Map>> update(String id, Map data) async {
    DocumentReference reference =
        await Firestore.instance.collection('pedidos').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(reference, data);
    });
  }

  Future<String> delete(String id) async {


    DocumentReference reference =
        await Firestore.instance.collection('pedidos').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'deleted';
  }

}
