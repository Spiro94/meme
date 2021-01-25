import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  MemeBloc() : super(MemeInitial());

  @override
  Stream<MemeState> mapEventToState(
    MemeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
