import 'dart:convert';
import 'dart:io';
import 'package:flutter_ninja/movie.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlKey = 'api_key=14a6b88819d39c69a823e94eedbd21d7';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase = 'https://api.themoviedb.org/3/search/movie?';
  final String urlIncludeAdult = '&include_adult=true';
  final String urlQuery = '&query=';

  Future<List<dynamic>> getUpcoming() async {
    final String url =
        '$urlBase$urlUpcoming$urlKey$urlLanguage$urlIncludeAdult';
    http.Response response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = response.body;
      final jsonResponse = jsonDecode(responseBody);
      final moviesMap = jsonResponse['results'];
      return moviesMap.map((movieMap) => Movie.fromJson(movieMap)).toList();
    } else {
      return null;
    }
  }

  Future<List> searchMovie(String query) async {
    http.Response response =
        await http.get('$urlSearchBase$urlKey$urlQuery$query$urlIncludeAdult');

    if (response.statusCode == HttpStatus.ok) {
      String responseBody = response.body;
      final jsonResponse = jsonDecode(responseBody);
      final moviesMap = jsonResponse['results'];
      return moviesMap.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      return null;
    }
  }
}
