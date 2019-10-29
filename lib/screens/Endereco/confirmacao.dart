
import 'package:bloc_pattern/bloc_pattern.dart' as pattern;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/components/addeditCard.dart';
import 'package:food_ordering_app/model/place_item.dart';
import 'package:food_ordering_app/repository/endereco_repository.dart';
import 'package:food_ordering_app/screens/Comanda/comanda_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_bloc.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_event.dart';
import 'package:food_ordering_app/screens/Endereco/endereco_state.dart';
import 'package:food_ordering_app/screens/LoginEmail/login_bloc.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'endereco_bloc.dart';

class ConfirmacaoEndereco extends StatefulWidget {
  final PlaceItemRes end;

  ConfirmacaoEndereco({Key key, this.end}) : super(key: key);

  @override
  _ConfirmacaoEnderecoState createState() =>
      new _ConfirmacaoEnderecoState(end: this.end);
}

class _ConfirmacaoEnderecoState extends State<ConfirmacaoEndereco> {
  PlaceItemRes end;
  Map<String, dynamic> endereco = Map<String, dynamic>();
  final _loginBloc = pattern.BlocProvider.getBloc<LoginBloc>();
  final _enderecoBloc = EnderecoBloc(EnderecoRepository());
  final TextEditingController _rotulo = new TextEditingController();
  final TextEditingController _endereco = new TextEditingController();
  final TextEditingController _numero = new TextEditingController();
  final TextEditingController _complemento = new TextEditingController();
  final TextEditingController _cep = new TextEditingController();
  final TextEditingController _bairro = new TextEditingController();
  final TextEditingController _cidade = new TextEditingController();
  final TextEditingController _estado = new TextEditingController();
  final TextEditingController _instrucoes = new TextEditingController();

  _ConfirmacaoEnderecoState({this.end});

  @override
  void initState() {
    
    var aux = end.address.split(',');

    _endereco.text = aux[0].trim();
    _numero.text = aux[1].split('-')[0].trim();
    _bairro.text = aux[1].split('-')[1].trim();
    _cidade.text = aux[2].split('-')[0].trim();
    _estado.text = aux[2].split('-')[1].trim();
    _cep.text = aux[3].trim();

  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
//    final _comandaBloc = BlocProvider.of<ComandaBloc>(context);
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(
                Icons.chevron_left,
                size: 40.0,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: new Text(
            "Confirmação Endereço",
            style: new TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocListener(
          bloc: _enderecoBloc,
          listener: (context, state) {
            if (state is EnderecoInitial) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.mensagem),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context,true);
            }
            if (state is EnderecoFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<EnderecoEvent, EnderecoState>(
              bloc: _enderecoBloc,
              builder: (BuildContext context,
                  EnderecoState state,) {
                return Container(
                    padding: EdgeInsets.all(10.0),
                    child:
                    Column(
                      children: <Widget>[
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Rótulo',
                          textAlign: TextAlign.end,
                          customWidth: 2.0,
                          controller: _rotulo,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Endereço',
                          textAlign: TextAlign.end,
                          customWidth: 2.0,
                          controller: _endereco,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          textAlign: TextAlign.end,
                          title: 'Número',
                          customWidth: 2.0,
                          controller: _numero,
                          tipoTeclado: TextInputType.number,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Complemento',
                          textAlign: TextAlign.end,
                          customWidth: 1.8,
                          controller: _complemento,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'CEP',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _cep,
                          tipoTeclado: TextInputType.number,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Bairro',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _bairro,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Cidade',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _cidade,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Estado',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _estado,
                          tipoTeclado: TextInputType.text,
                        ),
                        AddEditCard(
                          focus: FocusNode(),
                          enable: true,
                          title: 'Instrucoes',
                          textAlign: TextAlign.end,
                          customWidth: 1.6,
                          controller: _instrucoes,
                          tipoTeclado: TextInputType.text,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        InkWell(
                          onTap: () async{

                            if(_rotulo.value == null || _rotulo.value.text.isEmpty){
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Informe um rótulo antes de salvar'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            endereco['rotulo'] = _rotulo.text;
                            endereco['endereco'] = _endereco.text;
                            endereco['numero'] = _numero.text;
                            endereco['complemento'] = _complemento.text;
                            endereco['cep'] = _cep.text;
                            endereco['bairro'] = _bairro.text;
                            endereco['cidade'] = _cidade.text;
                            endereco['estado'] = _estado.text;
                            endereco['instrucoes'] = _instrucoes.text;
                            endereco['longitute'] = end.lng;
                            endereco['latitude'] = end.lat;
                            if(_loginBloc.firebaseUser != null && _loginBloc.firebaseUser.email != null){
                              endereco['usuario'] = _loginBloc.firebaseUser.email;
                            } else{
                              endereco['usuario'] = await UniqueIdentifier.serial;
                            }
                            _enderecoBloc.dispatch(SaveButtonPressed(data: MapEntry(null, endereco)));

                          },
                          child:
                          Container(
                            child: new Text('Salvar',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            width: screenSize.width - 20,
                            height: 45.0,
                            alignment: FractionalOffset.center,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                              const BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    )

                );
              }),)


    );
  }
}
