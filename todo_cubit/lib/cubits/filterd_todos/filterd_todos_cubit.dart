// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/models/toto_model.dart';

part 'filterd_todos_state.dart';

class FilterdTodosCubit extends Cubit<FilterdTodosState> {
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;

  final List<Todo> initialTodos;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;

  FilterdTodosCubit({
    required this.initialTodos,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
}) : super(FilterdTodosState(filterdTodos:  initialTodos)){
  todoFilterSubscription = todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
    setFilterdTodos();
  });

  todoSearchSubscription = todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
    setFilterdTodos();
  });

  todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) {
    setFilterdTodos();
  });
}

  void setFilterdTodos(){
    List<Todo> _filterTodos;

    switch (todoFilterCubit.state.filter){
      case Filter.active: 
        _filterTodos = todoListCubit.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed: 
        _filterTodos = todoListCubit.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all: 
        _filterTodos = todoListCubit.state.todos;
        break;
    }
    if(todoSearchCubit.state.searchTerm.isNotEmpty){
      _filterTodos = _filterTodos.where((Todo todo) => todo.desc.toLowerCase().contains(todoSearchCubit.state.searchTerm)).toList();
    }
    emit(state.copyWith(filterdTodos: _filterTodos));
  }
  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
