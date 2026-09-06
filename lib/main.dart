import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/favorites_screen.dart';

final _goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      name: 'home',
    ),
    GoRoute(
      path: '/recipe/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return RecipeDetailScreen(recipeId: id);
      },
      name: 'recipe_detail',
    ),
    GoRoute(
      path: '/add-recipe',
      builder: (context, state) => const AddRecipeScreen(),
      name: 'add_recipe',
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
      name: 'favorites',
    ),
  ],
);

void main() {
  runApp(const FoodieApp());
}

class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MaterialApp.router(
      title: 'Foodie',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routerDelegate: _goRouter.routerDelegate,
      routeInformationParser: _goRouter.routeInformationParser,
      routeInformationProvider: _goRouter.routeInformationProvider,
    );
  }
}