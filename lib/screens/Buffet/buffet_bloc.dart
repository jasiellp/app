import 'dart:async';
import 'package:food_ordering_app/repository/buffet_repository.dart';
import 'package:food_ordering_app/screens/Buffet/buffet_event.dart';
import 'package:food_ordering_app/screens/Buffet/buffet_state.dart';
import 'package:bloc/bloc.dart';

class BuffetBloc extends Bloc<BuffetEvent, BuffetState> {
  final BuffetRepository buffetRepository;

  BuffetBloc(this.buffetRepository);

  @override
  BuffetState get initialState => BuffetInitial();

  @override
  Stream<BuffetState> mapEventToState(BuffetEvent event) async* {


    if (event is SaveButtonPressed) {
      yield BuffetLoading();

      try {

        await buffetRepository.create(event.data);
      } catch (error) {
        yield BuffetFailure(error: error.toString());
      }
    }

    if (event is DeleteButtonPressed) {
      yield BuffetLoading();

      try {

        await buffetRepository.delete(event.data['id']);
      } catch (error) {
        yield BuffetFailure(error: error.toString());
      }
    }

    if(event is GetBuffet){
      yield BuffetLoading();
      try{
        var data = await buffetRepository.get();
        yield BuffetLoaded(buffet: data);

      } catch(error){
        yield BuffetFailure(error: error.toString());
      }
    }

    if(event is GetBuffets){
      yield BuffetLoading();
      try{
        var data = await buffetRepository.getAll();
        yield BuffetsLoaded(buffets: data);

      } catch(error){
        yield BuffetFailure(error: error.toString());
      }
    }
  }
}
