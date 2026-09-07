import 'package:multi_screen_app/models/recipe.dart';

class RecipeProvider {
  final List<Recipe> _recipes = [
    Recipe(
      id: 1,
      title: 'Pasta Carbonara',
      description: 'A classic Italian pasta dish with eggs, cheese, and pancetta',
      imageUrl: 'https://images.unsplash.com/photo-1621505303934eb7c5d5f1e6?w=400&h=300&fit=crop',
      categories: ['Italien', 'Pâtes'],
      rating: 4.5,
      prepTime: 30,
    ),
    Recipe(
      id: 2,
      title: 'Sushi Roll',
      description: 'Fresh Japanese rice with fish and vegetables',
      imageUrl: 'https://images.unsplash.com/photo-1616212304862-e8a608501e64?w=400&h=300&fit=crop',
      categories: ['Japonais', 'Riz'],
      rating: 4.8,
      prepTime: 45,
    ),
    Recipe(
      id: 3,
      title: 'Tacos',
      description: 'Mexican tortillas with seasoned meat and fresh toppings',
      imageUrl: 'https://images.unsplash.com/photo-1608419517988-f34b885ad322?w=400&h=300&fit=crop',
      categories: ['Mexicain', 'Street Food'],
      rating: 4.3,
      prepTime: 20,
    ),
    Recipe(
      id: 4,
      title: 'Chicken Curry',
      description: 'Aromatic Indian chicken dish with spices and coconut milk',
      imageUrl: 'https://images.unsplash.com/photo-1616212304862-e8a608501e64?w=400&h=300&fit=crop',
      categories: ['Indien', 'Curry'],
      rating: 4.7,
      prepTime: 50,
    ),
  ];

  List<Recipe> get recipes => _recipes;

  List<Recipe> get favorites => _recipes.where((r) => r.isFavorite).toList();

  List<Recipe> search(String query) {
    if (query.isEmpty) return _recipes;
    return _recipes.where((recipe) {
      final q = query.toLowerCase();
      return recipe.title.toLowerCase().contains(q) ||
          recipe.description.toLowerCase().contains(q) ||
          recipe.categories.any((c) => c.toLowerCase().contains(q));
    }).toList();
  }

  Recipe? getById(int id) => _recipes.firstWhere((r) => r.id == id);

  void addRecipe(Recipe recipe) {
    final maxId = _recipes.isEmpty
        ? 0
        : _recipes.map((r) => r.id).reduce((a, b) => a > b ? a : b);
    _recipes.add(recipe.copyWith(id: maxId + 1));
  }
}