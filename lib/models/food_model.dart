// food_model.dart
class FoodItem {
  final String name;
  final String imageUrl;
  final double caloriesPer100g;
  double quantity; // Add a quantity property

  FoodItem({
    required this.name,
    required this.imageUrl,
    required this.caloriesPer100g,
    this.quantity = 0.0, // Default quantity to 0
  });
}
