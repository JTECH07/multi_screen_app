import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_screen_app/models/recipe.dart';
import 'package:multi_screen_app/providers/recipe_provider.dart';
import 'package:multi_screen_app/widgets/recipe_card.dart';

class _FavoritesScreenState extends State<FavoritesScreen> {
  final RecipeProvider _provider = RecipeProvider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldColor = isDark ? Colors.grey[900] : Colors.white;

    final favorites = _provider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue[100],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                'Aucun favori pour l\'instant',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                var recipe = favorites[index];
                return Dismissible(
                  key: Key('fav_${recipe.id}'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    setState(() {
                      recipe = recipe.copyWith(isFavorite: false);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Retiré des favoris')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  child: RecipeCard(
                    key: Key('fav_recipe_${recipe.id}'),
                    recipe: recipe,
                    onFavoriteToggle: null,
                  ),
                );
              },
            ),
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  // ignore: return_of_invalid_type
  State<FavoritesScreen> createState() => _FavoritesScreenState as State<FavoritesScreen>;
}