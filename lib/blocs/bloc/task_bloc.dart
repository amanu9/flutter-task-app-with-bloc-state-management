import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc/task_state.dart';
import 'package:flutter_tasks_app/blocs/bloc/tast_event.dart';
import 'package:flutter_tasks_app/models/task.dart';

class TasksBloc extends Bloc<TaskEvent, TaskState> {
  TasksBloc() : super(TaskState()) {
    on<AddTask>(_onaddTask);
    on<DeleteTask>(_ondeleteTask);
    on<UpdateTask>(_onupdateTask);
  }
  void _onaddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      allTask: List.from(state.allTask)..add(event.task),
    ));
  }

  void _ondeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      allTask: List.from(state.allTask)..remove(event.task),
    ));
  }

  void _onupdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTask.indexOf(task);
    List <Task> allTasks = List.from(state.allTask)..remove(task);
    task.isDone == false
? allTasks.insert(index, task.copyWith(isDone: true)):allTasks.insert(index,task.copyWith(isDone: false));
    emit(TaskState(allTask: allTasks));
     
  
  }
}
