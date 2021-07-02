part of 'resep_bloc.dart';

abstract class ResepEvent extends Equatable {
  const ResepEvent();
  @override
  List<Object> get props => [];
}

class ResepAdd extends ResepEvent {
  // final String title;

  // ResepAdd(this.title);
  final ResepModel resepmodel;

  const ResepAdd(this.resepmodel);

  @override
  List<Object> get props => [resepmodel];
}

class ResepDelete extends ResepEvent {
  final ResepModel resepmodel;

  const ResepDelete(this.resepmodel);

  @override
  List<Object> get props => [resepmodel];
}

class ResepFetch extends ResepEvent {
  @override
  List<Object> get props => [];
}

class ResepDeleteAll extends ResepEvent {}
