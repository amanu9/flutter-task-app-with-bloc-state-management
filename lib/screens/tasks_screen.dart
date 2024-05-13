import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc/task_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc/task_state.dart';
import 'package:flutter_tasks_app/blocs/bloc/tast_event.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/screens/drawer.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key}) : super(key: key);
  static const id = "task screen";
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Add Task"),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  controller: titleController,
                  decoration: const InputDecoration(
                      label: Text("Title"), border: OutlineInputBorder()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) {
                            // Show a SnackBar with an error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a task title.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            var task = Task(title: titleController.text);
                            context.read<TasksBloc>().add(AddTask(task: task));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task added successfully!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Clear the titleController
                            titleController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add Task")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TaskState>(
      builder: (context, state) {
        List<Task> taskList = state.allTask;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {
                  _addTask(context);
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer:const  MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Center(
                child: Chip(
                  label: Text(
                    'Tasks:',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      taskList.length, // Use 'taskList' instead of 'listTask'
                  itemBuilder: (context, index) {
                    var task = taskList[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: Checkbox(
                        onChanged: (values) {
                          context.read<TasksBloc>().add(UpdateTask(task: task));
                        },
                        value: task.isDone,
                      ),
                      onLongPress: () =>
                          context.read<TasksBloc>().add(DeleteTask(task: task)),
                    );
                  },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context);
            },
           // tooltip:t(context).title,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
