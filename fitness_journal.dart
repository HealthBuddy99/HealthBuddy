import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fitness_data.dart';

class FitnessJournalPage extends StatelessWidget {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final journalData = Provider.of<FitnessJournalData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Journal"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Section
            TextField(
              controller: _activityController,
              decoration: InputDecoration(
                labelText: 'Activity',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.fitness_center, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(
                labelText: 'Calories Burned',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.local_fire_department, color: Colors.teal),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description, color: Colors.teal),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_activityController.text.isNotEmpty &&
                    _caloriesController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  journalData.addEntry(
                    _activityController.text,
                    int.parse(_caloriesController.text),
                    _descriptionController.text,
                  );
                  _activityController.clear();
                  _caloriesController.clear();
                  _descriptionController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Add Entry", style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            // Journal Entries Section
            Expanded(
              child: journalData.journalEntries.isEmpty
                  ? const Center(child: Text("No journal entries yet!"))
                  : ListView.builder(
                itemCount: journalData.journalEntries.length,
                itemBuilder: (context, index) {
                  final entry = journalData.journalEntries[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.teal),
                      title: Text(
                        "${entry['activity']} (${entry['caloriesBurned']} kcal)",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${entry['description']}\nDate: ${entry['date']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          journalData.removeEntry(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                onPressed: journalData.clearEntries,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.teal),
                ),
                child: const Text("Clear All Entries", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
