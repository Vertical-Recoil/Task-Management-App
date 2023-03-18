// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void _addNewTask() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddTaskForm(
              onTaskAdded: (newTask) {
                setState(() {
                  tasks.add(newTask);
                });
                //Navigator.of(context).pop(); //Do not include this for it will cause the user to pop back to login page!
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskNinjaPlus'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Text(
                    'TaskNinjaPlus',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.deepPurple[900],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Task',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Assignees',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Priority',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _addNewTask,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[900],
                      ),
                      child: const Text('Add Task'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].name),
                  subtitle: Text(tasks[index].assignees),
                  trailing: Text(tasks[index].priority),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  final String name;
  final String assignees;
  final String priority;

  Task({required this.name, required this.assignees, required this.priority});
}

class AddTaskForm extends StatefulWidget {
  final void Function(Task) onTaskAdded;

  const AddTaskForm({required this.onTaskAdded});

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _taskName;
  late String _assignees;
  String _priority = 'Low';

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onTaskAdded(Task(
        name: _taskName,
        assignees: _assignees,
        priority: _priority,
      ));
    }
    Navigator.pop(context);
    print('bork');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter task details',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the task details';
                }
                return null;
              },
              onSaved: (value) => _taskName = value!,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter assignees',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter assignees';
                }
                return null;
              },
              onSaved: (value) => _assignees = value!,
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: 'Select priority',
              ),
              value: _priority,
              items: ['Low', 'Moderate', 'High']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 94, 27, 27),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _submitForm(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green[900],
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
