import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime? selectedDate;

  Future<void> _showAddGoalDialog() async {
    String title = '';
    DateTime? pickedDate;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Goal Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => title = value,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  pickedDate == null
                      ? 'Select Date'
                      : DateFormat.yMMMd().format(pickedDate!),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() => pickedDate = date);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (title.isNotEmpty && pickedDate != null) {
                  final user = _auth.currentUser;
                  if (user != null) {
                    await _firestore.collection('goals').add({
                      'userId': user.uid,
                      'title': title,
                      'date': pickedDate,
                      'createdAt': FieldValue.serverTimestamp(),
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteGoal(String goalId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Goal'),
          content: const Text('Are you sure you want to delete this goal?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _firestore.collection('goals').doc(goalId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Goals'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('goals')
            .where('userId', isEqualTo: user?.uid)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              final data = goal.data() as Map<String, dynamic>;
              final date = (data['date'] as Timestamp).toDate();

              return Dismissible(
                key: Key(goal.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => _deleteGoal(goal.id),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(data['title']),
                    subtitle: Text(DateFormat.yMMMd().format(date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditGoalDialog(goal.id, data),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGoalDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showEditGoalDialog(
      String goalId, Map<String, dynamic> data) async {
    final titleController = TextEditingController(text: data['title']);
    DateTime? pickedDate = (data['date'] as Timestamp).toDate();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Goal Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  pickedDate == null
                      ? 'Select Date'
                      : DateFormat.yMMMd().format(pickedDate!),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: pickedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() => pickedDate = date);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _firestore.collection('goals').doc(goalId).update({
                  'title': titleController.text,
                  'date': pickedDate,
                  'updatedAt': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
