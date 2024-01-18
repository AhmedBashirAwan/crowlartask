import 'package:dio/dio.dart';
import 'package:movies_app/model/genre_model.dart';
import '../model/results_model.dart';

/// this file is for Api callings using Dio package
Dio dio = Dio();
String key = '  ';
Future<Movies> fetchData(int id) async {
  //for fetching movies
  final url = 'https://api.themoviedb.org/3/discover/movie?api_key=${key}';
  try {
    final Response response = await dio.get(url);
    if (response.statusCode == 200) {
      final Movies movies = Movies.fromJson(response.data, id);
      print('Fetched ${movies.results.length} movies successfully.');
      return movies;
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
    throw Exception('Failed to fetch data. Error: $error');
  }
}

Future<List<Genre>> fetchGenre() async {
  // for fetching all of the geners in TMDB database
  final url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=${key}';
  try {
    final Response response = await dio.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;
      List<Genre> genres = List.from(
          responseData['genres'].map((genre) => Genre.fromJson(genre)));

      print('Fetched ${genres.length} genres successfully.');
      return genres;
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception(
          'Failed to fetch genres. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching genres: $error');
    throw Exception('Failed to fetch genres. Error: $error');
  }
}
