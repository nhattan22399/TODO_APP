import 'package:flutter/material.dart';
import 'package:todo_cubit/pages/create_todo.dart';
import 'package:todo_cubit/pages/search_and_filter_todo.dart';
import 'package:todo_cubit/pages/show_todos.dart';
import 'package:todo_cubit/pages/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: [
                TodoHeader(),
                createTodo(),
                SizedBox(height: 20.0,),
                SearchAndFilterTodo(),
                ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

