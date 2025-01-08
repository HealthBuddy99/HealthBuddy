import 'package:fitness/fitness_challenges.dart';
import 'package:fitness/water_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calorie_tracker.dart';
import 'food_log.dart';
import 'fitness_journal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _calories = 1200;
  int _waterIntake = 5; // in cups
  int _calorieGoal = 2000;
  int _waterGoal = 8; // cups
  List<String> _foodLog = ["Oatmeal", "Grilled Chicken", "Salad"];
  String _userName = "User"; // Default name
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Health Buddy",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Your Name',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateName,
                child: const Text("Save Name"),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF0E4EAE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 89),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(Icons.person, color: Color(0xFF4A90E2), size: 40),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Hello, $_userName!",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Today's Progress",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Progress Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildProgressCard(
                    'Calorie Tracker',
                    _calories,
                    _calorieGoal,
                    Icons.local_fire_department,
                    Colors.orange,
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalorieTrackerPage()),
                    ),
                  ),
                  _buildProgressCard(
                    'Water Intake',
                    _waterIntake,
                    _waterGoal,
                    Icons.local_drink,
                    Colors.blue,
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WaterTrackerPage()),
                    ),
                  ),
                ],
              ),
            ),
            // Food Log Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Food Log',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _foodLog.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: const Icon(Icons.fastfood, color: Colors.green),
                          title: Text(
                            _foodLog[index],
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: _goToFoodLogPage,
                          child: const Text("View Food Log",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Fitness Journey and Challenges Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildSummaryCard(
                    'Fitness Journey',
                    'Track your progress!',
                    Icons.fitness_center,
                    Colors.green,
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FitnessJournalPage()),
                    ),
                  ),
                  _buildSummaryCard(
                    'Fitness Challenges',
                    'Take up challenges!',
                    Icons.directions_run,
                    Colors.red,
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FitnessChallengesPage()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, int progress, int goal, IconData icon, Color color, VoidCallback onTap) {
    double percentage = (progress / goal);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
            ),
            CircularProgressIndicator(
              value: percentage,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            Text(
              "${progress} / ${goal}",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _goToFoodLogPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodLogPage()),
    );
  }

  void _updateName() {
    setState(() {
      _userName = _nameController.text.isEmpty ? "User" : _nameController.text;
    });
    Navigator.pop(context);
  }
}
