import 'package:http/http.dart' as http;
import 'package:roxy1/model/movis.dart';
import 'dart:convert';

class MovieApi {
  static const apiKey = '5be15963d87eaa4cdaa7a29a11866c31';
  static const baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Movie>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> movies = data['results'];
      return movies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch trending movies');
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> movies = data['results'];
      return movies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }


   static Future<dynamic> getTVShows() async {
    final String url = '$baseUrl/tv/popular?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to fetch TV shows');
    }
  }
    static Future<dynamic> getAnimations() async {
    final String url = '$baseUrl/discover/movie?api_key=$apiKey&with_genres=16';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to fetch animations');
    }
  }
    static Future<dynamic> getPopularPeople() async {
    final String url = '$baseUrl/person/popular?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to fetch popular people');
    }
  }

  

  static Future<Movie> getMovieDetails(int movieId) async {
    final url = '$baseUrl/movie/$movieId?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Movie.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }


  static Future<List<dynamic>> getMovieCast(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = json.decode(response.body);
      final castList = decodedData['cast'];
      return castList;
    } catch (error) {
      throw Exception('Failed to fetch movie cast: $error');
    }
  }
  static Future<List<dynamic>> getMovieVideos(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = json.decode(response.body);
      final videosList = decodedData['results'];
      return videosList;
    } catch (error) {
      throw Exception('Failed to fetch movie videos: $error');
    }
  }

}


