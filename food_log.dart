import 'package:flutter/material.dart';
import 'food_api.dart'; // Import your food service file

class FoodLogPage extends StatefulWidget {
  @override
  _FoodLogPageState createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  final TextEditingController _foodController = TextEditingController();
  Map<String, dynamic>? _foodDetails;
  final FoodService _foodService = FoodService();
  bool _isLoading = false;

  void _fetchFoodDetails() async {
    final foodName = _foodController.text.trim();
    if (foodName.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _foodDetails = null; // Reset details during loading
      });

      try {
        final details = await _foodService.getNutritionalInfoFromOpenAI(foodName);
        setState(() {
          _foodDetails = details;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: Unable to fetch details."),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a food name."),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Log', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[50],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover Your Food\'s Nutrition',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _foodController,
                      decoration: InputDecoration(
                        hintText: 'Enter food name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[600]),
                          onPressed: () => _foodController.clear(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _fetchFoodDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                )
              else if (_foodDetails != null)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_foodDetails!['image'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            _foodDetails!['image'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _foodDetails!['name'],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Calories: ${_foodDetails!['details']['calories']} kcal',
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]),
                            ),
                            Text(
                              'Protein: ${_foodDetails!['details']['protein']} g',
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]),
                            ),
                            Text(
                              'Fat: ${_foodDetails!['details']['fat']} g',
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]),
                            ),
                            Text(
                              'Vitamins: ${_foodDetails!['details']['vitamins']}',
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Text(
                    "No data available yet.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
