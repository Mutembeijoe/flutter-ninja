import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlKey = 'api_key=14a6b88819d39c69a823e94eedbd21d7';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<String> getUpcoming() async {
    final String url = '$urlBase$urlUpcoming$urlKey$urlLanguage';
    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      String responseBody = response.body;
      return responseBody;
    } else {
      return null;
    }
  }
}
