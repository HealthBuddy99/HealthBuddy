import 'package:flutter/material.dart';

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int currentIntake = 4; // Current intake in glasses
  int dailyGoal = 8; // Daily goal in glasses

  void _addWater() {
    setState(() {
      if (currentIntake < dailyGoal) {
        currentIntake++;
      }
    });
  }

  void _resetWater() {
    setState(() {
      currentIntake = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentIntake / dailyGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          color: Colors.lightBlue.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title with icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop, size: 50, color: Colors.blueAccent),
                    const SizedBox(width: 10),
                    const Text(
                      'Hydration Goal',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Display current intake and goal
                Text(
                  '$currentIntake / $dailyGoal glasses',
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blueAccent,
                  minHeight: 10,
                ),
                const SizedBox(height: 20),
                // Buttons for adding water and resetting
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _addWater,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                      child: const Text('Add Water'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _resetWater,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Hydration reminder
                Text(
                  'Drink water regularly to stay hydrated!',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                ),
                const SizedBox(height: 20),
                // Emoji feedback based on hydration
                currentIntake < dailyGoal
                    ? Icon(Icons.sentiment_dissatisfied, size: 50, color: Colors.redAccent)
                    : Icon(Icons.sentiment_satisfied, size: 50, color: Colors.greenAccent),
                const SizedBox(height: 30),
                // Actionable history section (could be graph or calendar)
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Your water intake history will appear here.',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
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
