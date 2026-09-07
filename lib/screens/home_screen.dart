import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_screen_app/models/recipe.dart';
import 'package:multi_screen_app/providers/recipe_provider.dart';
import 'package:multi_screen_app/widgets/search_bar.dart' as search_bar;
import 'package:multi_screen_app/widgets/recipe_card.dart';

class _HomeScreenState extends State<HomeScreen> {
  final RecipeProvider _provider = RecipeProvider();
  String _searchQuery = '';
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredRecipes = _provider.search(_searchQuery);
    final displayedRecipes = _showFavoritesOnly
        ? filteredRecipes.where((r) => r.isFavorite).toList()
        : filteredRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodie'),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          search_bar.SearchBar(
            onChanged: (query) {
              setState(() => _searchQuery = query);
            },
            hintText: 'Rechercher des recettes',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('Favoris uniquement:'),
                Checkbox(
                  value: _showFavoritesOnly,
                  onChanged: (val) =>
                      setState(() => _showFavoritesOnly = val ?? false),
                ),
              ],
            ),
          ),
          Expanded(
            child: displayedRecipes.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? 'Aucune recette trouvée'
                          : 'Aucune recette correspondante',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedRecipes.length,
                    itemBuilder: (context, index) {
                      var recipe = displayedRecipes[index];
                      return RecipeCard(
                        key: Key('recipe_${recipe.id}'),
                        recipe: recipe,
                        onFavoriteToggle: () => setState(
                          () => recipe = recipe.copyWith(isFavorite: !recipe.isFavorite),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: return_of_invalid_type
  State<HomeScreen> createState() => _HomeScreenState as State<HomeScreen>;
}