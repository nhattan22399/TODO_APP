import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

class createTodo extends StatefulWidget {
  
  const createTodo({super.key});

  @override
  State<createTodo> createState() => _createTodoState();
}

class _createTodoState extends State<createTodo> {
  
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: newTodoController,
      decoration: InputDecoration(labelText: 'What to do?'),
      onSubmitted: (String? todoDesc) {
        if(todoDesc != null && todoDesc.trim().isNotEmpty){
          context.read<TodoListCubit>().addTodo(todoDesc);
          newTodoController.clear();
        }
      },
    );
  }
}