part of 'meme_bloc.dart';

abstract class MemeState extends Equatable {
  const MemeState();
  
  @override
  List<Object> get props => [];
}

class MemeInitial extends MemeState {}
