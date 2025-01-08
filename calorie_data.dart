import 'package:flutter/material.dart';

class CalorieTrackerData with ChangeNotifier {
  int dailyGoal = 10000;
  int consumedCalories = 0;
  List<Map<String, dynamic>> foodLog = [];

  // Function to add food and calories to the log
  void addFood(String foodName, int calories) {
    foodLog.add({
      'name': foodName,
      'calories': calories,
      'time': DateTime.now().toString(), // Store the current time as a string
    });
    consumedCalories += calories;
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Function to remove food from the log
  void removeFood(int index) {
    consumedCalories -= foodLog[index]['calories'] as int;
    foodLog.removeAt(index);
    notifyListeners();
  }

  // Function to reset the food log
  void resetFoodLog() {
    foodLog.clear();
    consumedCalories = 0;
    notifyListeners();
  }

  // Function to set the daily goal
  void setDailyGoal(int goal) {
    dailyGoal = goal;
    notifyListeners(); // Notify listeners that the goal has changed
  }
}
