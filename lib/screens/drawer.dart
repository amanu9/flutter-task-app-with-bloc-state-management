import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc/task_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc/task_state.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Container(
              color: Colors.blue,
              width: double.infinity,
              child: const Text("Amanu Application"),
            ),
          ),
          BlocBuilder<TasksBloc, TaskState>(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(TasksScreen.id);
              },
              child: ListTile(
                leading:const  Icon(Icons.folder_special),
                title: const Text("My Task"),
                trailing: Text('${state.allTask.length}'),
              ),
            );
          }),
          const Divider(thickness: 3, color: Colors.blue),

          GestureDetector(
            onTap: (() => Navigator.of(context).pushReplacementNamed(RecycleBin.id)),
            child: const ListTile(
              leading: Icon(Icons.delete),
              title: Text("Bin"),
              trailing: Text("0"),
            ),
          )
          
        ],
      )),
    );
  }
}
