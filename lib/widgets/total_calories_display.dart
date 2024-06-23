import 'package:flutter/material.dart';
import '../models/food_model.dart'; // Import your FoodItem model

class TotalCaloriesDisplay extends StatelessWidget {
  final double totalCalories;

  TotalCaloriesDisplay({required this.totalCalories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Calories: ${totalCalories.toStringAsFixed(2)} kcal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),

        ],
      ),
    );
  }
}
