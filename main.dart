import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'calorie_data.dart';
import 'fitness_data.dart';
import 'fitness_journal.dart';
import 'login_page.dart';
import 'home_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HealthBuddyApp());
}
class HealthBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalorieTrackerData()), // Provide CalorieTrackerData
        ChangeNotifierProvider(create: (_) => FitnessJournalData()), // Provide FitnessJournalData
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Buddy',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const Color(0xFFF8F4FF),
        ),
        initialRoute: '/login', // Start with the login page
        routes: {
          '/login': (context) => LoginPage(), // Login page route
          '/home': (context) => HomePage(), // Home page route
          '/fitnessJournal': (context) => FitnessJournalPage(), // Fitness journal page route
        },
      ),
    );
  }
}
