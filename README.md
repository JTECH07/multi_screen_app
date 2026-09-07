# Multi Screen App

A Flutter application demonstrating multi-screen navigation with GoRouter, featuring a recipe browsing experience.

## App Overview

**Foodie** is a recipe exploration app with 4 main screens:
- **Home** - Browse recipes with search and favorites filtering
- **Recipe Detail** - View full recipe information with parameters
- **Add Recipe** - Form to submit new recipes
- **Favorites** - Manage favorite recipes

## Features

- **4 distinct screens** with dedicated functionality
- **GoRouter** for declarative navigation with named routes
- **Search & filtering** on the home screen (by title, description, or category)
- **Favorites system** - mark recipes as favorites and view them separately
- **Recipe form** with validation for 5 fields (image URL, title, description, prep time, categories)
- **Light & dark theme** support with automatic system detection
- **Reusable widgets** in `widgets/` directory
- **Responsive design** adaptable to mobile and tablet

## Screens

### Home Screen
- Search bar to filter recipes
- "Favorites only" checkbox filter
- List of recipes with cards showing image, title, rating
- Favorite toggle on each card
- Navigation to Favorites screen

### Recipe Detail Screen
- Full recipe view with image, title, rating, prep time, categories, description
- Favorite toggle in app bar
- Receives recipe ID via route parameter `/recipe/:id`

### Add Recipe Screen
- Form with 5 validated fields:
  - Image URL (must be valid HTTP/HTTPS URL)
  - Title (minimum 3 characters)
  - Description
  - Prep time (positive number in minutes)
  - Categories (comma-separated)
- On successful submission, navigates back to previous screen
- New recipe auto-gets assigned an incrementing ID

### Favorites Screen
- List of favorited recipes
- Swipe-to-dismiss to remove from favorites
- Each item displays recipe card with favorite status

## Navigation

All navigation is handled via **GoRouter** with named routes:
- `/` → HomeScreen (route name: `home`)
- `/recipe/:id` → RecipeDetailScreen (route name: `recipe_detail`)
- `/add-recipe` → AddRecipeScreen (route name: `add_recipe`)
- `/favorites` → FavoritesScreen (route name: `favorites`)

## Reusable Widgets

### `widgets/recipe_card.dart`
- Displays recipe image, title, rating, and favorite button
- Supports custom height parameter
- Handles light/dark theme colors

### `widgets/search_bar.dart`
- Reusable TextField with border styling
- Accepts onChanged callback and optional hintText
- Adapts colors for dark/light theme

### `widgets/theme_toggle.dart`
- IconButton to toggle between light/dark mode
- Shows sun icon for light mode, moon for dark mode

## Technical Details

- **State management**: Custom `RecipeProvider` managing recipe data
- **Theming**: Light/dark theme using `ThemeData` with `Brightness`
- **No hardcoded data in widgets**: Data comes from `RecipeProvider`
- **Adaptive**: Works on mobile and tablet screens
- **15+ Flutter widgets** used across the app

## Getting Started

### Prerequisites

- Flutter SDK (3.10+ recommended)
- Dart SDK (3.10+ recommended)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/JTECH07/multi_screen_app.git
   cd multi_screen_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```
   or for web:
   ```bash
   flutter run -d chrome
   ```

### Build APK
```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── main.dart          # App entry point with GoRouter and theme config
├── models/recipe.dart # Recipe data model
├── providers/recipe_provider.dart # Recipe data provider
└── screens/           # Application screens
│   ├── home_screen.dart
│   ├── recipe_detail_screen.dart
│   ├── add_recipe_screen.dart
│   └── favorites_screen.dart
└── widgets/           # Reusable widgets
    ├── recipe_card.dart
    ├── search_bar.dart
    └── theme_toggle.dart
```

## Dependencies

Key dependencies in `pubspec.yaml`:
- `go_router: ^18.0.1` - Declarative routing
- No external state management (custom RecipeProvider)

## Author

Created as a Flutter multi-screen application demonstration.