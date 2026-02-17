import 'dart:convert';
import 'models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {

  static Future<void> addFavorite(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favorites =
        prefs.getStringList('favorites') ?? [];

    favorites.add(jsonEncode({
      
      'name': movie.name,
      'image': movie.image,
      'summary': movie.summary,
      'rating': movie.rating,
      'genres': movie.genres,
    }));

    await prefs.setStringList('favorites', favorites);
  }

  static Future<List<Movie>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favorites =
        prefs.getStringList('favorites') ?? [];

    return favorites.map((item) {
      final json = jsonDecode(item);
      return Movie(
        
        name: json['name'],
        image: json['image'],
        summary: json['summary'],
        rating: json['rating'],
        genres: List<String>.from(json['genres']),
        
        language: "",
      );
    }).toList();
  }
}
