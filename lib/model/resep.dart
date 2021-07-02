import 'package:equatable/equatable.dart';

class ResepModel extends Equatable {
  final String imageUrl;
  final String title;
  final String time;
  final bool isFavorite;

  const ResepModel(this.imageUrl, this.title, this.time, this.isFavorite);

  @override
  List<Object> get props => [imageUrl, title, time, isFavorite];
}
