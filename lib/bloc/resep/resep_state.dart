part of 'resep_bloc.dart';

abstract class ResepState extends Equatable {
  const ResepState();
}

class ResepInitial extends ResepState {
  @override
  List<Object> get props => [];
}

class ResepLoaded extends ResepState {
  final List<ResepModel> listmodel;
  final List<ResepModel> favorite;

  ResepLoaded(this.listmodel, this.favorite);

  @override
  List<Object> get props => [listmodel, favorite];
}
