import 'package:flutter/material.dart';

import '../models/food_model.dart';
class CartItemTile extends StatelessWidget {
  final FoodItem foodItem;
  final Function(double) onQuantityChanged;

  CartItemTile({required this.foodItem, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(foodItem.imageUrl, height: 50, width: 50),
        title: Text(foodItem.name),
        subtitle: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Quantity (grams)'),
          onChanged: (value) {
            final quantity = double.tryParse(value) ?? 0.0;
            onQuantityChanged(quantity);
          },
        ),
      ),
    );
  }
}