// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filterd_todos_cubit.dart';

class FilterdTodosState extends Equatable {
  final List<Todo> filterdTodos;
  FilterdTodosState({
    required this.filterdTodos,
  });
  
  factory FilterdTodosState.initial(){
    return FilterdTodosState(filterdTodos: []);
  }

  @override
  List<Object?> get props => [filterdTodos];

  @override
  String toString() => 'FilterdTodosState(filterdTodos: $filterdTodos)';

  FilterdTodosState copyWith({
    List<Todo>? filterdTodos,
  }) {
    return FilterdTodosState(
      filterdTodos: filterdTodos ?? this.filterdTodos,
    );
  }
}
