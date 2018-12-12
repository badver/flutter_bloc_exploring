import 'dart:convert';

import 'package:bloc_study/src/models/item_model.dart';
import 'package:bloc_study/src/models/trailer_model.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _baseUrl = "https://api.themoviedb.org/3/movie";
  final _apiKey = 'api_key_place_here'; // TODO put api key

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    }

    throw Exception('Failed to load data');
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
        await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    }

    throw Exception('Failed to load trailers');
  }
}
