import 'package:flutter/material.dart';

class AddFoodPage extends StatefulWidget {
  final Function(String, int) onFoodAdded; // Callback to pass data back

  AddFoodPage({required this.onFoodAdded});

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _foodController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Add Food', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon at the top for better visual balance
                Icon(Icons.fastfood, color: Colors.blueAccent, size: 50),

                // Instructional text
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Text(
                    'Please enter the food name and calories to track your intake.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),

                // Food Name Input
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _foodController,
                    decoration: InputDecoration(
                      labelText: 'Food Name',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      prefixIcon: Icon(Icons.fastfood, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),

                // Calories Input
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: TextField(
                    controller: _caloriesController,
                    decoration: InputDecoration(
                      labelText: 'Calories',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      prefixIcon: Icon(Icons.local_fire_department, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                // Add Food Button
                ElevatedButton(
                  onPressed: () {
                    final food = _foodController.text;
                    final calories = int.tryParse(_caloriesController.text) ?? 0;
                    if (food.isNotEmpty && calories > 0) {
                      widget.onFoodAdded(food, calories); // Pass data back
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Food Added Successfully!')),
                      );
                      Navigator.pop(context); // Go back to the previous page
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter valid food and calorie information.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Add Food',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
