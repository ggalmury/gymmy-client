import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc() : super(InitSelectedDateState()) {
    on<SelectedDateEvent>((event, emit) {
      if (event is SetSelectedDateEvent) _setDate(event, emit);
    });
  }

  void _setDate(SetSelectedDateEvent event, emit) {
    emit(CurrentSelectedDateState(selectedDate: event.date));
  }
}

// event
abstract class SelectedDateEvent extends Equatable {}

class SetSelectedDateEvent extends SelectedDateEvent {
  final DateTime date;

  SetSelectedDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

// state
abstract class SelectedDateState extends Equatable {
  final DateTime selectedDate;

  const SelectedDateState({required this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}

class InitSelectedDateState extends SelectedDateState {
  InitSelectedDateState() : super(selectedDate: DateTime.now());

  @override
  List<Object?> get props => [selectedDate];
}

class CurrentSelectedDateState extends SelectedDateState {
  const CurrentSelectedDateState({required super.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}
