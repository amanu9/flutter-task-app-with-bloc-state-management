import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/drawer.dart';
class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}):super(key:key);
 static const id = "recycle screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Ricycle Bin'),
            actions: [
              IconButton(
                onPressed: () {
                  
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
         drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks:',
                  ),
                ),
              ),
             
            ],
          ),
          
        );
  }
}