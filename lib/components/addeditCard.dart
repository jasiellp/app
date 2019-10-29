import 'package:flutter/material.dart';

BoxDecoration border = new BoxDecoration(
  border: new Border(
    bottom:
    new BorderSide(width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.2)),
  ),
);
InputDecoration inputDecoration = new InputDecoration(
  border: InputBorder.none,
  labelStyle: new TextStyle(fontSize: 14.0),
);
TextStyle titleStyle =
new TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.5), fontSize: 14.0);
TextStyle subTitle =
new TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.8), fontSize: 10.0);
decoratePic(pic) {
  return new BoxDecoration(
    borderRadius: new BorderRadius.all(const Radius.circular(50.0)),
    color: Colors.grey,
    image: new DecorationImage(
      image: new AssetImage(pic),
      fit: BoxFit.cover,
    ),
  );
}


class AddEditCard extends StatelessWidget {
  final bool enable;
  final String initialValue;
  final String title;
  final FocusNode focus;
  final TextAlign textAlign;
  final int maxLines;
  final double customWidth;
  final TextEditingController controller;
  final TextInputType tipoTeclado;


  AddEditCard({this.enable, this.initialValue, this.textAlign, this.title, this.focus, this.controller, this.maxLines, this.customWidth, this.tipoTeclado});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new InkWell(
      onTap: () {
        if (focus != null) {
          if (enable) FocusScope.of(context).requestFocus(focus);
        } else {
          print('focus true');
        }
      },
      child: new Container(
          decoration: (title != 'Repeat' ? border : null),
          padding: new EdgeInsets.only(
              left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: new Text(title, style: titleStyle),
              ),
              new Container(
                width: screenSize.width / (customWidth ?? 2.4),
                child: new TextFormField(
                  textAlign: textAlign ?? TextAlign.start,
                  controller: controller,
                  maxLines: maxLines ?? 1,
                  enabled: enable,
                  decoration: inputDecoration,
                  focusNode: focus,
                  keyboardType: tipoTeclado,
                ),
              ),
            ],
          )),
    );
  }
}

class PicCard extends StatelessWidget {
  final List<dynamic> list;
  final bool enable;
  final String title;

  PicCard({this.enable, this.title, this.list});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Container(
        decoration: border,
        padding:
        new EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: new Text(title, style: titleStyle),
            ),
            new Container(
              width: screenSize.width / 2.4,
              height: 40.0,
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, int index) {
                    return new Container(
                        width: 40.0,
                        height: 40.0,
                        margin: const EdgeInsets.only(left: 10.0),
                        decoration: decoratePic(list[index]));
                  }),
            )
          ],
        ));
  }
}

class AddEditDropDownCard extends StatefulWidget {
  final bool enable;
  final String initialValue;
  final String title;
  final FocusNode focus;
  final List<MapEntry<String, String>> list;
  final Map selected;
  final double customWidth;
  final Function(Map map) onChange;

  const AddEditDropDownCard({Key key, this.enable, this.initialValue, this.title, this.focus, this.customWidth, this.list, this.selected, this.onChange}) : super(key: key);

  @override
  AddEditDropDownCardState createState() => new AddEditDropDownCardState(enable: this.enable, initialValue: this.initialValue, title: this.title, focus: this.focus, customWidth: this.customWidth, list: this.list, selected: this.selected, onChange: this.onChange);
}

class AddEditDropDownCardState extends State<AddEditDropDownCard> {

  final bool enable;
  final String initialValue;
  final String title;
  final FocusNode focus;
  final List<MapEntry<String, String>> list;
  final Map selected;
  final double customWidth;
  final Function(Map map) onChange;

  AddEditDropDownCardState({this.enable, this.initialValue, this.title, this.focus, this.customWidth, this.list, this.selected, this.onChange});

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new InkWell(
      onTap: () {
        if (focus != null) {
          if (enable) FocusScope.of(context).requestFocus(focus);
        } else {
          print('focus true');
        }
      },
      child: Container(
        decoration: border,
        padding: new EdgeInsets.only(left: 15.0, right: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenSize.width / customWidth,
              child:Text(title, style: titleStyle),
            ),

            Expanded(
                child:  new Padding(
                    padding:
                    new EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        onChanged: (String newValue) {
                          setState(() {
                            selected[title.toUpperCase()] = newValue;
                            onChange(selected);

                          });
                        },
                        hint: new Text('SELECIONE'),
                        value: selected[title.toUpperCase()],
                        items: list.map((MapEntry value) {
                          return new DropdownMenuItem<String>(
                            value: value.key,
                            child: new Text(value.value),
                          );
                        }).toList(),
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}

class BuscaCard extends StatefulWidget {

  final TextEditingController query;
  final bool enabled;
  final String title;
  final Function(String query) onChange;

  const BuscaCard({Key key, this.enabled, this.query, this.title, this.onChange}) : super(key: key);

  @override
  BuscaCardState createState() => new BuscaCardState(enabled: this.enabled, query: this.query, title: this.title, onChange: this.onChange);
}

class BuscaCardState extends State<BuscaCard> {

  final TextEditingController query;
  final String title;
  final bool enabled;
  final Function(String query) onChange;
  bool loading = false;

  BuscaCardState({this.query, this.enabled, this.title, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: TextField(
          onChanged: (newValue) async {
            onChange(newValue);
          },
          controller: query,
          keyboardType: TextInputType.text,
          enabled: enabled ?? true,
          decoration: InputDecoration(
              labelText: title,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              suffixIcon: loading ? CircularProgressIndicator(
                value: null,
                strokeWidth: 3.0,
              ) :
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 40.0,
                  ),
                  onPressed: () {

                  }
              ),
              hintStyle: TextStyle(
                  color: Colors.black, fontSize: 14.0)),
        ));
  }
}


