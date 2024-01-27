import 'package:flutter/material.dart';
import '../model/model.dart';
import 'editscreen.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Task> tasks = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            trailing: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (value) {
                setState(() {
                  tasks[index].isCompleted = value!;
                });
              },
            ),
            onTap: () {
              updateTask(index);
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter Title',
                            hintStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter Description',
                            hintStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addTask();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            tooltip: 'Add Task',
            child: const Icon(
              Icons.add,
              color: Colors.green,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              deleteCompletedTasks();
            },
            tooltip: 'Delete Completed Tasks',
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  void addTask() {
    if (titleController.text.isNotEmpty) {
      setState(() {
        tasks.add(
          Task(
            title: titleController.text,
            description: descriptionController.text,
          ),
        );
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void updateTask(int index) async {
    Task? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: tasks[index]),
      ),
    );

    setState(() {
      tasks[index] = result!;
    });
    }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void deleteCompletedTasks() {
    setState(() {
      tasks.removeWhere((task) => task.isCompleted);
    });
  }
}
