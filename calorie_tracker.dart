import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_food_page.dart';
import 'calorie_data.dart';

class CalorieTrackerPage extends StatefulWidget {
  @override
  _CalorieTrackerPageState createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  @override
  Widget build(BuildContext context) {
    // Get the data from the provider
    final calorieTrackerData = Provider.of<CalorieTrackerData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              calorieTrackerData.resetFoodLog(); // Reset food log via provider
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _setDailyGoal(context, calorieTrackerData);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Daily Calorie Goal: ${calorieTrackerData.dailyGoal} kcal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: calorieTrackerData.consumedCalories /
                            calorieTrackerData.dailyGoal,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          calorieTrackerData.consumedCalories /
                              calorieTrackerData.dailyGoal >=
                              1
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${calorieTrackerData.consumedCalories} kcal',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${((calorieTrackerData.consumedCalories /
                              calorieTrackerData.dailyGoal) *
                              100)
                              .toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: calorieTrackerData.foodLog.length, // Use data from provider
                itemBuilder: (context, index) {
                  var foodItem = calorieTrackerData.foodLog[index];
                  return Dismissible(
                    key: Key(foodItem['name']),
                    onDismissed: (direction) {
                      calorieTrackerData.foodLog.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${foodItem['name']} removed'),
                      ));
                    },
                    background: Container(color: Colors.red),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.fastfood),
                        title: Text(foodItem['name']),
                        subtitle: Text('Calories: ${foodItem['calories']} kcal'),
                        trailing: Text(foodItem['time']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFoodPage(
                      onFoodAdded: (foodName, calories) {
                        calorieTrackerData.addFood(foodName, calories); // Add food via provider
                      },
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void _setDailyGoal(BuildContext context, CalorieTrackerData data) {
    TextEditingController goalController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Daily Calorie Goal'),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter your daily goal (kcal)'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int goal = int.tryParse(goalController.text) ?? data.dailyGoal;
                data.setDailyGoal(goal); // Update goal via provider
                Navigator.of(context).pop();
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
  }
}