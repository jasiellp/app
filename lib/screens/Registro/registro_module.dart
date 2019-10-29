import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/Registro/registro_bloc.dart';
import 'package:food_ordering_app/screens/Registro/registro_page.dart';

class RegistroModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegistroBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegistroPage();

  static Inject get to => Inject<RegistroModule>.of();
}
