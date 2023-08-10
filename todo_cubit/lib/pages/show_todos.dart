// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit/cubits/filterd_todos/filterd_todos_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/models/toto_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterdTodosCubit>().state.filterdTodos;  
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey,);
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_){
            context.read<TodoListCubit>().RemoveTodo(todos[index]);
          },
          confirmDismiss: (_){
            return showDialog(
              context: context, 
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you really want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context,false), 
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context,true), 
                      child: Text('Yes'),
                    ),
                  ],
                );
              }
            );
          },
          child: TodoItem(todo: todos[index]),
        );
      },
    );
  }
}

Widget showBackground(int direction){
  return Container(
    margin: EdgeInsets.all(4.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.white,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: Icon( Icons.delete, color: Colors.red, size: 30.0),

  );
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(

      onTap: (){
        showDialog(
          context: context, 
          builder: (context){
            bool _error = false;
            textController.text = widget.todo.desc;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return AlertDialog(
                  title: Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text('Cancel')
                    ),
                    TextButton(
                      onPressed: () {
                        setState((){
                          _error = textController.text.isEmpty ? true : false;
                          if(!_error){
                            context.read<TodoListCubit>().editTodo(
                                widget.todo.id,
                              textController.text,
                            );
                            
                            Navigator.pop(context);
                          }
                        });
                      }, 
                      child: Text('Edit')
                    )
                  ],
                );
              }
            );
          }
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked){ 
          context.read<TodoListCubit>().ToggleTodo(widget.todo.id);
        },
      ),
      title: Text(
        widget.todo.desc
      ),
    );
  }
}