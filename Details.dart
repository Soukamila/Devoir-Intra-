import 'package:flutter/material.dart';
import 'models.dart';
import 'FavoritesServises.dart';


class DetailsPage extends StatelessWidget {
  final Movie movie;

  const DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (movie.image != null)
              Center(
                child: Image.network(
                  movie.image!,
                  height: 300,
                ),
              ),

            const SizedBox(height: 16),

            Text(
              movie.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Genres: ${movie.genres.join(', ')}"),

            const SizedBox(height: 10),

            Text("Rating: ${movie.rating}"),

            const SizedBox(height: 15),

            Text(movie.summary),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await FavoritesService.addFavorite(movie);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ajouté aux favoris")),
                );
              },
              child: const Text("Ajouter aux favoris"),
            ),
          ],
        ),
      ),
    );
  }
}
