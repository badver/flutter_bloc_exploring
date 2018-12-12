import 'package:bloc_study/src/models/item_model.dart';
import 'package:bloc_study/src/models/trailer_model.dart';
import 'package:bloc_study/src/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => movieApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      movieApiProvider.fetchTrailer(movieId);
}
