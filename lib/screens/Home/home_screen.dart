import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ug/components/Home/search_button.dart'; // Make sure this import is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> goalsList = [];
  DateTime? selectedDate;

  void _showAddTodoDialog() {
    String title = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Add Your Goals',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              CupertinoTextField(
                placeholder: 'Title',
                onChanged: (value) => title = value,
              ),
              const SizedBox(height: 15),
              CupertinoButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now(), // Always set to the current date
                    firstDate: DateTime.now(), // No dates before today
                    lastDate: DateTime(2101),
                  );
                  setState(() {
                    selectedDate = pickedDate;
                  });
                },
                child: Text(selectedDate == null
                    ? 'Select Date'
                    : DateFormat.yMMMd().format(selectedDate!)),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (title.isNotEmpty && selectedDate != null) {
                  setState(() {
                    goalsList.add({
                      'title': title,
                      'date': DateFormat.yMMMd().format(selectedDate!),
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _deleteGoal(int index) {
    setState(() {
      goalsList.removeAt(index);
    });
  }

  void _updateGoal(int index) {
    String title = goalsList[index]['title']!;
    DateTime? selectedDate =
        DateFormat.yMMMd().parse(goalsList[index]['date']!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Update Your Goals',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              CupertinoTextField(
                controller: TextEditingController(text: title),
                placeholder: 'Title',
                onChanged: (value) => title = value,
              ),
              const SizedBox(height: 15),
              CupertinoButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate, // Set to currently selected date
                    firstDate: DateTime.now(), // No dates before today
                    lastDate: DateTime(3000),
                  );
                  setState(() {
                    selectedDate = pickedDate;
                  });
                },
                child: Text(DateFormat.yMMMd().format(selectedDate!)),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  goalsList[index] = {
                    'title': title,
                    'date': DateFormat.yMMMd().format(selectedDate!),
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchButton(
                hintText: "Search Here",
                labelText: "Search",
                textColor: Colors.black87,
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: goalsList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(goalsList[index]['title']!),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        _deleteGoal(index);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blue,
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Ensures card's rounded corners
                          ),
                          elevation: 4, // Optional shadow for effect
                          child: ListTile(
                            leading: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            title: Text(goalsList[index]['title']!),
                            subtitle: Text(goalsList[index]['date']!),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _updateGoal(index),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        backgroundColor: const Color(0xffFECD01),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
