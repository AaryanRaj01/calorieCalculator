import 'package:flutter/material.dart';
import 'package:notfitassignment/models/food_model.dart';
class FoodItemTile extends StatelessWidget {
  final FoodItem foodItem;
  final bool isSelected;
  final VoidCallback onTap; // Changed to VoidCallback

  FoodItemTile({
    required this.foodItem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(foodItem.imageUrl, height: 50, width: 50),
        title: Text(foodItem.name),
        subtitle: Text('${foodItem.caloriesPer100g.toString()} kcal/100g'),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: Colors.green)
            : null,
        onTap: onTap, // Assign onTap directly
      ),
    );
  }
}