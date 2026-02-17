class Movie {
  final String name;
  final String? image;
  final String summary;
  final double? rating;  // Changez en double? (optionnel)
  final List<String> genres;
  final String language;

  Movie({
    required this.name,
    required this.summary,
    this.image,
    this.rating,  // Plus de required
    required this.genres,
    required this.language,
  });

  Map<String, dynamic> toJson() {  // toJson avec minuscule
    return {
      'name': name,
      'image': image,
      'summary': summary,
      'genres': genres,
      'rating': rating,
      'language': language,
    };
  }

  // DÉCOMMENTEZ ET CORRIGEZ fromJson
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'] ?? "",
      summary: json['summary'] ?? "",
      image: json['image'] != null ? json['image']['medium'] : null,
      rating: json['rating'] != null && json['rating']['average'] != null
          ? (json['rating']['average']).toDouble()
          : null,
      genres: List<String>.from(json['genres'] ?? []),
      language: json['language'] ?? "",
    );
  }
}