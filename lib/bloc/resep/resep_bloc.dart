import 'dart:async';

import 'package:appresep/model/resep.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'resep_event.dart';
part 'resep_state.dart';

class ResepBloc extends Bloc<ResepEvent, ResepState> {
  ResepBloc() : super(ResepInitial());

  @override
  Stream<ResepState> mapEventToState(
    ResepEvent event,
  ) async* {
    if (event is ResepFetch) {
      List<ResepModel> resepModel = [];
      resepModel.add(ResepModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Tumis Sayur',
          '12',
          false));
      resepModel.add(ResepModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Tumis Sayur2',
          '12',
          false));
      resepModel.add(ResepModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Tumis Sayur3',
          '12',
          false));
      yield ResepLoaded(resepModel, []);
    } else if (event is ResepAdd) {
      List<ResepModel> resepModel = [];
      List<ResepModel> favoriteresep = [];

      if (state is ResepLoaded) {
        resepModel.addAll((state as ResepLoaded).listmodel);
        favoriteresep.addAll((state as ResepLoaded).favorite);
      }
      for (var i = 0; i < resepModel.length; i++) {
        if (resepModel[i].title == event.resepmodel.title) {
          resepModel[i] = ResepModel(event.resepmodel.imageUrl,
              event.resepmodel.title, event.resepmodel.time, true);
          print(resepModel[i]);

          break;
        }
      }

      favoriteresep.add(event.resepmodel);
      yield ResepLoaded(resepModel, favoriteresep);
    } else if (event is ResepDelete) {
      List<ResepModel> resepModel = [];
      List<ResepModel> favoriteresep = [];
      if (state is ResepLoaded) {
        resepModel.addAll((state as ResepLoaded).listmodel);
        favoriteresep.addAll((state as ResepLoaded).favorite);
      }
      for (var i = 0; i < resepModel.length; i++) {
        if (resepModel[i].title == event.resepmodel.title) {
          resepModel[i] = ResepModel(event.resepmodel.imageUrl,
              event.resepmodel.title, event.resepmodel.time, false);

          break;
        }
      }
      for (var i = 0; i < favoriteresep.length; i++) {
        if (favoriteresep[i].title == event.resepmodel.title) {
          favoriteresep.remove(favoriteresep[i]);
          break;
        }
      }

      yield ResepLoaded(resepModel, favoriteresep);
    } else if (event is ResepDeleteAll) {
      List<ResepModel> resepModel = [];
      List<ResepModel> favoriteresep = [];
      if (state is ResepLoaded) {
        resepModel.addAll((state as ResepLoaded).listmodel);
        favoriteresep.remove((state as ResepLoaded).favorite);
      }

      for (var i = 0; i < resepModel.length; i++) {
        resepModel[i] = ResepModel(resepModel[i].imageUrl, resepModel[i].title,
            resepModel[i].time, false);
      }
      yield ResepLoaded(resepModel, favoriteresep);
    }
  }
}

// Future<List<ResepModel>> _fetchPosts([int startIndex = 0]) async {
//   final List<ResepModel> resepModel = [];
//   resepModel.add(ResepModel(
//       'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
//       'Tumis Sayur',
//       '12'));
//       if(resepModel.isNotEmpty){
//         return resepModel
//       }
// }
