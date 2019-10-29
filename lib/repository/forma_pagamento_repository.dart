import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FormaPagamentoRepository {
  Future<Map> get(String id) async {
    DocumentSnapshot querySnapshot =
        await Firestore.instance.collection('formas-pagamento').document(id).get();

    if (querySnapshot.exists) {

      var aux = querySnapshot.data;
      aux['id'] = id;
      return aux;
    }

    return Map();
  }

  Future<List<Map>> getAll() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('formas-pagamento').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => x.data).toList();
    }

    return List<Map>();
  }

  Future<String> create(Map data) async {

    await Firestore.instance.collection('formas-pagamento').add(data).catchError((e) {
      print(e);
      return e.toString();
    });

    return 'Criado com sucesso!';
  }

  Future<String> update(String id, Map data) async {
    DocumentReference reference =
        await Firestore.instance.collection('formas-pagamento').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(reference, data);
    });

    return 'Atualizado com sucesso!';
  }

  Future<String> delete(String id) async {


    DocumentReference reference =
        await Firestore.instance.collection('formasPagamento').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'Deletado com sucesso!';
  }

}
