import 'package:flutter/material.dart';
import 'package:multi_screen_app/models/recipe.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final List<Recipe> Function(String)? filteredRecipes;
  final String? hintText;

  const SearchBar({
    super.key,
    required this.onChanged,
    this.filteredRecipes,
    this.hintText,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700] : Colors.grey[300],
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Rechercher des recettes',
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[400],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}