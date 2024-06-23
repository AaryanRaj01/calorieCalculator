import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CaloriesDetailScreen extends StatelessWidget {
  final double totalCalories;
  final Map<FoodItem, double> foodQuantities;

  CaloriesDetailScreen({required this.totalCalories, required this.foodQuantities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Detail'),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: foodQuantities.length,
                itemBuilder: (context, index) {
                  final foodItem = foodQuantities.keys.toList()[index];
                  final quantity = foodQuantities.values.toList()[index];
                  final calories = foodItem.caloriesPer100g * (quantity / 100);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${foodItem.name}:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Quantity: ${quantity.toStringAsFixed(2)} grams',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Calories per 100g: ${foodItem.caloriesPer100g} kcal',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Calories: ${calories.toStringAsFixed(2)} kcal',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Total Calories: ${totalCalories.toStringAsFixed(2)} kcal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
