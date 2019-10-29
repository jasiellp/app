import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {READY_FIRST, READY_LAST}

class PedidosBloc extends BlocBase {

  final _pedidosController = BehaviorSubject<List>();

  Stream<List> get outPedidos => _pedidosController.stream;

  Firestore _firestore = Firestore.instance;

  List<DocumentSnapshot> _pedidos = [];

  SortCriteria _criteria;

//  PedidosBloc(){
//    _addOrdersListener();
//  }

  void _addOrdersListener(){
    _firestore.collection("pedidos").orderBy("data_criado",descending: true).snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change){
        String oid = change.document.documentID;

        switch(change.type){
          case DocumentChangeType.added:
            _pedidos.add(change.document);
            break;
          case DocumentChangeType.modified:
            _pedidos.removeWhere((order) => order.documentID == oid);
            _pedidos.add(change.document);
            break;
          case DocumentChangeType.removed:
            _pedidos.removeWhere((order) => order.documentID == oid);
            break;
        }
      });

      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria){
    _criteria = criteria;

    _sort();
  }

  void _sort(){
    switch(_criteria){
      case SortCriteria.READY_FIRST:
        _pedidos.sort((a,b){
          int sa = a.data["data_criado"];
          int sb = b.data["data_criado"];

          if(sa < sb) return 1;
          else if(sa > sb) return -1;
          else return 0;
        });
        break;
      case SortCriteria.READY_LAST:
        _pedidos.sort((a,b){
          int sa = a.data["data_criado"];
          int sb = b.data["data_criado"];

          if(sa > sb) return 1;
          else if(sa < sb) return -1;
          else return 0;
        });
        break;
    }

    _pedidosController.add(_pedidos);
  }

  @override
  void dispose() {
    _pedidosController.close();
  }

}