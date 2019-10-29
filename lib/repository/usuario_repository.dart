import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UsuarioRepository {

  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendCodeToPhoneNumber(Map data) async {


    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
        print('Received phone auth credential: $phoneAuthCredential');
    };

    final PhoneVerificationFailed verificationFailed = (
        AuthException authException) {
        print('Phone number verification failed. Code: ${authException
            .code}. Message: ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + data['numero_telefone']);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: data['numero_telefone'],
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<Map> get(String id) async {
    DocumentSnapshot querySnapshot =
        await Firestore.instance.collection('usuarios').document(id).get();

    if (querySnapshot.exists) {

      var aux = querySnapshot.data;
      aux['id'] = id;
      return aux;
    }

    return Map();
  }

  Future<List<Map>> getAll() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('usuarios').getDocuments();

    if (querySnapshot.documents.length > 0) {
      return querySnapshot.documents.map((x) => x.data).toList();
    }

    return List<Map>();
  }

  Future<String> create(Map data) async {

    await Firestore.instance.collection('usuarios').add(data).catchError((e) {
      print(e);
      return e.toString();
    });

    return 'created';
  }

  Future<String> update(String id, Map data) async {
    DocumentReference reference =
        await Firestore.instance.collection('usuarios').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(reference, data);
    });

    return 'Atualizado com sucesso!';
  }

  Future<String> delete(String id) async {


    DocumentReference reference =
        await Firestore.instance.collection('usuarios').document(id);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.delete(reference);
    });

    return 'deleted';
  }

}
