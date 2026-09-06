class Recipe {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> categories;
  final double rating;
  final int prepTime;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.categories,
    required this.rating,
    required this.prepTime,
    this.isFavorite = false,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      categories: List<String>.from(map['categories']),
      rating: (map['rating'] as num).toDouble(),
      prepTime: map['prepTime'] as int,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'categories': categories,
      'rating': rating,
      'prepTime': prepTime,
      'isFavorite': isFavorite,
    };
  }

  Recipe copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? categories,
    double? rating,
    int? prepTime,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      prepTime: prepTime ?? this.prepTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}