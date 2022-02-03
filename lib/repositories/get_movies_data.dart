import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myflix_app/models/movie_model.dart';

class GetMoviesData {
  /// descrivo una funzione asincrona che effettuerà la chiamata http
  /// e farà il parsing per poter gestire i dati in dart
  static Future<List<MovieModel>> popular() async {
    /// url a cui effettuare la chiamata http
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=f10ccd72e0d02b50384e2e5f35ea0e3b');

    /// chiamata http
    final response = await http.get(url);

    return decodeMovie(response);
  }

  static List<MovieModel> decodeMovie(response) {
    /// decodifico il json nello specifico convento la stringa in Map
    final jsonData = json.decode(response.body);

    /// sostituisco ad ogni elemento del Map (oggetto javascript)
    /// una istanza della mia classe MovieModel (oggetto dart)
    /// per avere una lista(array) di istanze(oggetti) da poter
    /// facilmente manipolare in Dart
    final movies = (jsonData['results'] as List<dynamic>).map((movie) {
      return MovieModel.fromData(movie);
    }).toList();

    /// ritorno la mia lista di film
    return movies;
  }

  static Future<List<MovieModel>> search(String textToSearch) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=f10ccd72e0d02b50384e2e5f35ea0e3b&query=$textToSearch');

    final response = await http.get(url);

    return decodeMovie(response);
  }
}
