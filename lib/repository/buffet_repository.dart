import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class BuffetRepository {

  Future<MapEntry> get() async {
    //print("Data:" + DateTime.now().toLocal().toString());
    QuerySnapshot querySnapshot =
    await Firestore.instance.collection('buffets').orderBy('data')
        .where('data', isGreaterThanOrEqualTo: DateTime.now()).getDocuments();

    if (querySnapshot.documents.length > 0) {

      var document = querySnapshot.documents.first;

      document.data['pratos_list'] = List<MapEntry>();

      await Future.forEach(document.data['pratos'], (x) async {

        var reference = await (x as DocumentReference).get();

        document.data['pratos_list'].add(MapEntry(reference.documentID, reference.data));

      });


      return MapEntry(document.documentID, document.data);

    } else {

      QuerySnapshot querySnapshot =
      await Firestore.instance.collection('buffets').orderBy('data').getDocuments();

      if (querySnapshot.documents.length > 0) {

        var document = querySnapshot.documents.last;

        document.data['pratos_list'] = List<MapEntry>();

        await Future.forEach(document.data['pratos'], (x) async {

          var reference = await (x as DocumentReference).get();

          document.data['pratos_list'].add(MapEntry(reference.documentID, reference.data));

        });

        return MapEntry(document.documentID, document.data);
      }
    }

    return MapEntry(null, Map());
  }


  Future<List<Map>> getAll() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('buffet').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => x.data).toList();
    }

    return List<Map>();
  }

  Future<String> addUpdatePratos(MapEntry comanda) async {

    List<Map> buffet = [];
    comanda.value['pratos'].forEach((x){
      if(x.value['quantidade'] != null && x.value['quantidade'] > 0){

        var aux = Map();
        aux['id'] = x.key;
        aux['quantidade'] = x.value['quantidade'];

        buffet.add(aux);
      }
    });

    //var usuario = await _auth.currentUser();
    //comanda['usuario'] = usuario.uid ?? '';
    comanda.value['subtotal'] = 0;
    comanda.value['total'] = 0;
    comanda.value['entrega'] = 0;
    comanda.value['data'] = DateTime.now();
    comanda.value['buffet'] = buffet;

    if(comanda.key != null){
      await Firestore.instance.collection('comanda').document(comanda.key).setData(comanda.value).catchError((e) {
        return e.toString();
      });

      return comanda.key;
    } else {
      var reference = await Firestore.instance.collection('comanda').add(comanda.value).catchError((e) {
        return e.toString();
      });

      return reference.documentID;
    }

  }

  Future<String> create(Map data) async {

    await Firestore.instance.collection('buffet').add(data).catchError((e) {
      return e.toString();
    });

    return 'create';
  }

  Future<List<Map>> update(String id, Map data) async {
    DocumentReference reference =
        await Firestore.instance.collection('buffet').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(reference, data);
    });
  }

  Future<String> delete(String id) async {


    DocumentReference reference =
        await Firestore.instance.collection('buffet').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'deleted';
  }

}
