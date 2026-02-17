import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'Details.dart';

class Recherche extends StatefulWidget {
  const Recherche({super.key});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> searchRezul = [];
  bool isLoading = false;

  void searchMovies(String m) async {
    if (m.isEmpty) {
      setState(() {
        searchRezul = [];
      });
      return; // Important: sortir de la fonction si vide
    }

    setState(() {
      isLoading = true;
    });

    try {
      // CORRECTION: Utiliser l'endpoint de recherche, pas /shows
      dynamic results = await APIService.get(
          'https://api.tvmaze.com/search/shows?q=$m');

      setState(() {
        searchRezul = results.map<Movie>((item) {
          return Movie.fromJson(item['show']);
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de recherche: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher des films'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tapez un nom de film...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: searchMovies,
            ),
          ),

          // Résultats
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchRezul.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Aucun résultat',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        // CORRECTION: searchRezul au lieu de searchResults
                        itemCount: searchRezul.length,
                        itemBuilder: (context, index) {
                          return _buildSearchResult(searchRezul[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResult(Movie movie) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: movie.image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.image!,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              )
            : Container(
                width: 50,
                height: 70,
                color: Colors.grey[300],
                child: const Icon(Icons.movie),
              ),
        title: Text(
          movie.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (movie.genres.isNotEmpty)
            //   Text('Genres: ${movie.genres.join(', ')}'),
            // if (movie.rating != null && movie.rating! > 0)
            //   Row(
            //     children: [
            //       const Icon(Icons.star, color: Colors.amber, size: 16),
            //       const SizedBox(width: 4),
            //       Text('${movie.rating}/10'),
            //     ],
            //   ),
          ],
        ),
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailsPage(movie: movie), // movie = ton objet Movie ici
    ),
  );
},
        
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}