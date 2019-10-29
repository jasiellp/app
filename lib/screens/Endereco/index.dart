import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/platform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/model/place_item.dart';
import 'package:food_ordering_app/repository/endereco_repository.dart';
import 'package:food_ordering_app/theme/style.dart';

import 'confirmacao.dart';
import 'endereco_bloc.dart';
import 'endereco_event.dart';
import 'endereco_state.dart';

class Endereco extends StatefulWidget {
  Endereco({Key key}) : super(key: key);

  @override
  _EnderecoState createState() => new _EnderecoState();
}

class _EnderecoState extends State<Endereco> {
  final _blocEndereco = EnderecoBloc(EnderecoRepository());

  @override
  void initState() {
    _blocEndereco.dispatch(GetEnderecos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<EnderecoEvent, EnderecoState>(
        bloc: _blocEndereco,
        builder: (
          BuildContext context,
          EnderecoState state,
        ) {
          return new Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            appBar: new AppBar(
              elevation: 0.0,
              bottom: new PreferredSize(
                preferredSize: new Size(100.0, 70.0),
                child: BuscaCard(
                  title: 'Buscar endereço e número',
                  onChange: (str) {
                    _blocEndereco.dispatch(SearchEnderecos(keyword: str));
                  },
                ),
              ),
              leading: new IconButton(
                  icon: new Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: new Text(
                "Endereço de Entrega",
                style: new TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
              backgroundColor: Colors.white,
            ),
            body: Stack(
              children: <Widget>[
                (state is EnderecosLoaded)
                    ? Container(
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(5.0)),
                                  border: Border.all(
                                      color: state.enderecos[index]
                                                  .value['selecionado'] ==
                                              true
                                          ? Colors.red
                                          : Colors.grey[200])),
                              child: ListTile(
                                dense: true,
                                leading: Icon(
                                  Icons.location_on,
                                  color: state.enderecos[index]
                                              .value['selecionado'] ==
                                          true
                                      ? Colors.red
                                      : Colors.grey[200],
                                ),
                                title: Text(
                                  state.enderecos[index].value['rotulo'] ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "${state.enderecos[index].value['endereco']}, ${state.enderecos[index].value['numero']},"
                                            "${state.enderecos[index].value['complemento']}"),
                                    Text(
                                        "${state.enderecos[index].value['bairro']}"),
                                    Text(
                                        "${state.enderecos[index].value['cidade']}/${state.enderecos[index].value['estado']}"),
                                  ],
                                ),
                                onTap: () async {
                                  _blocEndereco.dispatch(SaveButtonPressed(
                                      data: MapEntry(state.enderecos[index].key,
                                          state.enderecos[index].value)));


                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Colors.white70,
                          ),
                          itemCount: state.enderecos.length,
                        ),
                      )
                    : Container(),
                Container(
                    width: screenSize.width,
                    height: 200.0,
                    child: StreamBuilder(
                      stream: _blocEndereco.placeStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == "start") {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          List<PlaceItemRes> places = snapshot.data;
                          return Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x88999999),
                                          offset: Offset(0, 5),
                                          blurRadius: 5.0)
                                    ],
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.location_on,
                                      color: Colors.grey[200],
                                    ),
                                    title: Text(
                                      places.elementAt(index).name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(places
                                        .elementAt(index)
                                        .address
                                        .replaceFirst(
                                            "${places.elementAt(index).name}, ",
                                            '')),
                                    onTap: () async {
                                      await Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmacaoEndereco(
                                                      end: places
                                                          .elementAt(index))));
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.white70,
                              ),
                              itemCount: places.length,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )),
              ],
            ),
          );
        });
  }
}
