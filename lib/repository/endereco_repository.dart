import 'dart:async';
import 'package:food_ordering_app/model/place_item.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:unique_identifier/unique_identifier.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;


class EnderecoRepository {
  Future<MapEntry> get() async {
    final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
    String identifier = await UniqueIdentifier.serial;
    if(_loginBloc.firebaseUser != null){
      identifier = _loginBloc.firebaseUser.email;
    }

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('enderecos').where('usuario', isEqualTo: identifier).orderBy('selecionado', descending: true).getDocuments();

    if (querySnapshot.documents.length > 0) {

      return querySnapshot.documents.map((x) => MapEntry(x.documentID, x.data)).toList().first;
    }

    return MapEntry(null, Map());
  }

  Future<List<MapEntry>> getAll() async {
    final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
    String identifier = await UniqueIdentifier.serial;
    if(_loginBloc.firebaseUser != null){
      identifier = _loginBloc.firebaseUser.email;
    }
    QuerySnapshot querySnapshot =
    await Firestore.instance.collection('enderecos').where('usuario', isEqualTo: identifier).getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => MapEntry(x.documentID, x.data)).toList();
    }

    return List<MapEntry>();
  }

  Future<List<PlaceItemRes>> searchAddress(keyword) async {


      String url =
          "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyDPaFRwkTfLGUgDovW6ZrldT9e77mYR7sU&language=pt&query=" +
              Uri.encodeQueryComponent(keyword);

      var res = await http.get(url);
      if (res.statusCode == 200) {
        return PlaceItemRes.fromJson(json.decode(res.body));

      } else {
        return List();
      }
  }

  Future<bool> foraPerimetro(destino) async {

    DocumentSnapshot doc = await Firestore.instance.collection('estabelecimento').document('nbh8iySX8UA8JMqLqFSP').get();


    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins="
            "${doc.data['lat_lng']}&destinations=${destino}&key=AIzaSyDPaFRwkTfLGUgDovW6ZrldT9e77mYR7sU";

    print(url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      Map<String,dynamic> retorno = json.decode(res.body);
      //Validando se distancia é maior que 2 km
      if (retorno['rows'][0]['elements'][0]['status'] != 'OK'){
        return true;
      }
      if(retorno['rows'][0]['elements'][0]['distance']['value'] > doc.data['perimetro_entrega']){
        return true;
      }
      return false;

    } else {
      return true;
    }
  }

  Future<String> save(MapEntry data) async {

    print(data);
    if(await foraPerimetro("${data.value['latitude']},${data.value['longitute']}") == true){
      return 'fora do perimetro';
    }



    var aux = "";
    if(data.value['usuario'] == null){
      data.value['usuario'] = await UniqueIdentifier.serial;
    }

    QuerySnapshot docSnapshot = await Firestore.instance
        .collection('enderecos')
    .where('usuario',isEqualTo: data.value['usuario'])
        .where('rotulo', isEqualTo: 'MINHA LOCALIZAÇÃO').getDocuments();
    if (docSnapshot.documents.length > 0) {
      docSnapshot.documents.forEach((x){
        if(data.value['rotulo'] == x.data['rotulo']) {
          data.value['selecionado'] = DateTime.now();
          Firestore.instance.collection('enderecos')
              .document(x.documentID)
              .setData(data.value, merge: true);
          aux = 'edited';
          return;
        }
      });
      if(aux == 'edited')
        return 'edited';
    }

    data.value['selecionado'] = DateTime.now();

    await Firestore.instance.collection('enderecos').document(data.key).setData(data.value).catchError((e) {
      return e.toString();
    });

    return 'create';
  }

  Future<String> delete(String id) async {


    DocumentReference reference =
        await Firestore.instance.collection('enderecos').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'deleted';
  }

  Future<PlaceItemRes> buscaEnderecoFixo(keyword) async {


    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyDPaFRwkTfLGUgDovW6ZrldT9e77mYR7sU&language=pt&query=" +
            Uri.encodeQueryComponent(keyword);

    //print("search >>: " + url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
//      print(res.body);
      return PlaceItemRes.fromJson(json.decode(res.body)).first;

    } else {
      return null;
    }
  }

}
