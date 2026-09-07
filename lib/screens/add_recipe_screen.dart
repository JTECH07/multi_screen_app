import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_screen_app/models/recipe.dart';
import 'package:multi_screen_app/providers/recipe_provider.dart';

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final RecipeProvider _provider = RecipeProvider();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _categoriesController = TextEditingController();
  String _imageUrl = '';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _categoriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue[100],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Nouvelle recette', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextFormField(
                onChanged: (value) => setState(() => _imageUrl = value),
                decoration: const InputDecoration(
                  labelText: 'URL de l\'image',
                  hintText: 'https://example.com/recipe.jpg',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une URL d\'image';
                  }
                  if (!value.startsWith('http://') && !value.startsWith('https://')) {
                    return 'Veuillez entrer une URL valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le titre est requis';
                  }
                  if (value.length < 3) {
                    return 'Le titre doit faire au moins 3 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  hintText: 'Description de la recette',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La description est requise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prepTimeController,
                decoration: const InputDecoration(
                  labelText: 'Temps de préparation (min)',
                  border: OutlineInputBorder(),
                  hintText: 'ex: 30',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le temps de préparation est requis';
                  }
                  final minutes = int.tryParse(value);
                  if (minutes == null || minutes <= 0) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoriesController,
                decoration: const InputDecoration(
                  labelText: 'Catégories (séparées par des virgules)',
                  border: OutlineInputBorder(),
                  hintText: 'ex: Italien, Pâtes',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Les catégories sont requises';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newRecipe = Recipe(
                      id: _provider.recipes.isEmpty
                          ? _provider.recipes.length + 1
                          : _provider.recipes.map((r) => r.id).reduce((a, b) => a > b ? a : b) + 1,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      imageUrl: _imageUrl.isNotEmpty ? _imageUrl
                          : 'https://images.unsplash.com/photo-1621505303934eb7c5d5f1e6?w=400&h=300&fit=crop',
                      categories: _categoriesController.text
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList(),
                      rating: 4.0,
                      prepTime: int.parse(_prepTimeController.text),
                    );

                    _provider.addRecipe(newRecipe);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recette ajoutée avec succès!')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Ajouter la recette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  // ignore: return_of_invalid_type
  State<AddRecipeScreen> createState() => _AddRecipeScreenState as State<AddRecipeScreen>;
}