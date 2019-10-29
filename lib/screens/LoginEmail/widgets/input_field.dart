import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextInputType typeKeyboard;

  InputField({this.icon, this.hint, this.obscure, this.stream, this.onChanged, this.typeKeyboard});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return Container(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                icon: Icon(icon, color: Colors.red,),
                labelText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[500])
                ),
                errorText: snapshot.hasError ? snapshot.error : null,
                errorStyle: TextStyle(color: Colors.redAccent),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
              ),
              style: TextStyle(color: Colors.black),
              obscureText: obscure,
              keyboardType: typeKeyboard,
            ),
          );
        }
    );
  }
}
