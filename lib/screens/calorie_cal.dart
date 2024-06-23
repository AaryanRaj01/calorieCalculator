import 'package:flutter/material.dart';
import '../data/food_example_data.dart'; // Import your food items data
import '../models/food_model.dart'; // Import your FoodItem model
import '../widgets/total_calories_display.dart';
import 'cart_screen.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final Set<FoodItem> _selectedFoods = {};

  void _toggleFoodSelection(FoodItem foodItem) {
    setState(() {
      if (_selectedFoods.contains(foodItem)) {
        _selectedFoods.remove(foodItem);
      } else {
        _selectedFoods.add(foodItem);
      }
    });
  }

  void _showCartSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected Items (${_selectedFoods.length})',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _selectedFoods.length,
                  itemBuilder: (context, index) {
                    final foodItem = _selectedFoods.toList()[index];
                    return ListTile(
                      title: Text(foodItem.name),
                      subtitle: Text('${foodItem.caloriesPer100g} calories per 100g'),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          foodItem.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _selectedFoods.remove(foodItem);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(selectedFoods: _selectedFoods),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange[700],
                  onPrimary: Colors.white,
                ),
                child: Text('Proceed to Calculate'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Foods'),
        backgroundColor: Colors.orange[700],
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: _selectedFoods.isNotEmpty ? _showCartSheet : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                final isSelected = _selectedFoods.contains(foodItem);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => _toggleFoodSelection(foodItem),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 150, // Adjust the height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(foodItem.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), // Semi-transparent background
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      foodItem.name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (_) => _toggleFoodSelection(foodItem),
                                    activeColor: Colors.orange[700],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedFoods.isNotEmpty
          ? FloatingActionButton(
        onPressed: _showCartSheet,
        backgroundColor: Colors.orange[700],
        child: Icon(Icons.add_shopping_cart),
      )
          : null,
    );
  }
}
