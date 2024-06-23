import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/total_calories_display.dart';
import 'detail_page.dart'; // Import your detail screen

class CartScreen extends StatefulWidget {
  final Set<FoodItem> selectedFoods;

  CartScreen({required this.selectedFoods});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<FoodItem, double> _foodQuantities = {};

  void _updateFoodQuantity(FoodItem foodItem, double quantity) {
    setState(() {
      _foodQuantities[foodItem] = quantity;
    });
  }

  double get totalCalories {
    return _foodQuantities.entries.fold(0.0, (total, entry) {
      return total + (entry.key.caloriesPer100g * (entry.value / 100));
    });
  }

  void _showCaloriesDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaloriesDetailScreen(totalCalories: totalCalories,foodQuantities: _foodQuantities),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Foods')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.selectedFoods.map((foodItem) {
                return CartItemTile(
                  foodItem: foodItem,
                  onQuantityChanged: (quantity) => _updateFoodQuantity(foodItem, quantity),
                );
              }).toList(),
            ),
          ),
          TotalCaloriesDisplay(totalCalories: totalCalories),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showCaloriesDetail(context),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange[700],
              onPrimary: Colors.white,
            ),
            child: Text('Show Calories Detail'),
          ),
        ],
      ),
    );
  }
}
