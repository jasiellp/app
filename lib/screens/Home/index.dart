import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/repository/endereco_repository.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/Home/style.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import "package:google_maps_webservice/geocoding.dart" as geo;
import 'package:location/location.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;
import 'package:unique_identifier/unique_identifier.dart';

LocationData currentLocation;
//var currentLocation;

var location = new Location();
bool permission = false;
String error;
//LocationResult result2;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final _blocEndereco = EnderecoBloc(EnderecoRepository());
  String endereco = '';
  final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
  Map<String,dynamic> arg_endereco;
  @override
  void initState() {
    _loginBloc.statusInicial();
    final geocoding = new geo.GoogleMapsGeocoding(
        apiKey: "AIzaSyAKTKdJ_6EOEI73PKvv0MdopH6ufcwzH2g");

    var comp = geo.Component('country', 'BR');
    location.getLocation().then((locationData) {

      var loc = new geo.Location(locationData.latitude, locationData.longitude);

      geocoding.searchByLocation(loc).then((response) {
        setState(() {
          endereco = response.results.first.formattedAddress;
        });
        var aux = endereco.split(',');

        arg_endereco = {
          'rotulo': 'MINHA LOCALIZAÇÃO',
          'endereco' :aux[0].trim(),
          'numero' :aux[1].split('-')[0].trim(),
          'bairro' :aux[1].split('-')[1].trim(),
          'cidade' : aux[2].split('-')[0].trim(),
          'estado' : aux[2].split('-')[1].trim(),
          'cep' : aux[3].trim(),
          'longitude': response.results.first.geometry.location.lng,
          'latitude':response.results.first.geometry.location.lat,
          'usuario': _loginBloc.firebaseUser != null  ?
        _loginBloc.firebaseUser.email : null
        };
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
//    Map<String, dynamic> endereco = Map<String, dynamic>();
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: GestureDetector(
          onTap: () async {
            if(_loginBloc.firebaseUser == null) {
              arg_endereco['usuario'] = await UniqueIdentifier.serial;
            } else {
              arg_endereco['usuario'] = _loginBloc.firebaseUser.email;
            }
            _blocEndereco.dispatch(SaveButtonPressed(data: MapEntry(null, arg_endereco)));
            Navigator.of(context).pushReplacementNamed("/HomeWithTab",
                arguments: arg_endereco);


          },
          child: Text(
            "Cardápio do Dia",
            style: new TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
        leading: new IconButton(
            icon: ImageIcon(
              ExactAssetImage('assets/footer-menu/cart.png'),
              color: Colors.red,
              size: 30.0,
            ),
            onPressed: () async {
              if(_loginBloc.firebaseUser == null) {
                arg_endereco['usuario'] = await UniqueIdentifier.serial;
              } else {
                arg_endereco['usuario'] = _loginBloc.firebaseUser.email;
              }
              Navigator.of(context).pushReplacementNamed("/HomeWithTab",
                  arguments: arg_endereco);
              _blocEndereco.dispatch(SaveButtonPressed(data: MapEntry(null, arg_endereco)));
            }),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Center(
                child: new Image(
              image: map,
              width: screenSize.width / 1.5,
              height: 1816 * screenSize.height / (506 * 15),
            )),
            Text(
              "Onde você quer",
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "receber seu pedido?",
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            new Column(
              children: <Widget>[
                BuscaCard(
                  title: 'Buscar endereço e número',
//                onChange: (item) => onChanged(item)
                ),
                new InkWell(
                  onTap: () async {
                    if(_loginBloc.firebaseUser == null) {
                      arg_endereco['usuario'] = await UniqueIdentifier.serial;
                    } else {
                      arg_endereco['usuario'] = _loginBloc.firebaseUser.email;
                    }
                    Navigator.of(context).pushReplacementNamed("/HomeWithTab",
                        arguments: arg_endereco);
                    _blocEndereco.dispatch(SaveButtonPressed(data: MapEntry(null, arg_endereco)));
                  },
                  child: new Container(
                      child: new Text(
                        'Usar minha localização',
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.white),
                      ),
                      width: screenSize.width,
                      height: 40.0,
                      margin: new EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                      alignment: FractionalOffset.center,
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0)),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 50.0,
                        padding: EdgeInsets.only(left: 10.0, right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              endereco,
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0),
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                _loginBloc.firebaseUser == null
                    ? Column(
                        children: <Widget>[
                          Text(
                            "Já tem um endereço salvo?",
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Entre na sua conta para selecionar",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "seu endereço",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : Center(
                        child: Text("Seja bem vindo!",
                        style: TextStyle(
                          fontSize: 16.0
                        ),),
                      ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/Login");
                  },
                  child: Text(
                    _loginBloc.firebaseUser != null
                        ? _loginBloc.firebaseUser.email
                        : 'Entrar',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  ),
                ),
                _loginBloc.firebaseUser != null
                    ? Container(
                        child: InkWell(
                          onTap: () {
                            _loginBloc.logoff();
                            Navigator.of(context).pushReplacementNamed('/Home');
                          },
                          child: const Text(
                            'Sair',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        width: screenSize.width - 20,
                        height: 45.0,
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0)),
                        ),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
