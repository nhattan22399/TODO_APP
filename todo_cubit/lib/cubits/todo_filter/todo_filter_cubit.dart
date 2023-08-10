import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit/models/toto_model.dart';

part 'todo_filter_state.dart';

class TodoFilterCubit extends Cubit<TodoFilterState> {
  TodoFilterCubit() : super(TodoFilterState.initial());

  void ChangeFilter(Filter newFilter) {
    emit(state.copyWith(filter: newFilter));
  } 
}