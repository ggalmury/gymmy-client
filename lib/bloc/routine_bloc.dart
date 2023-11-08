import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(InitRoutineState()) {
    on<RoutineEvent>((event, emit) {
      if (event is CreateRoutineEvent) _createRoutine(event, emit);
    });
  }

  void _createRoutine(CreateRoutineEvent event, emit) {
    Map<String, Routine> copiedState = Map.from(state.routine);
    String date = DateUtil.formatToYMD(event.date);

    if (copiedState[date] == null) {
      copiedState[date] =
          Routine(date: event.date, target: "가슴", workouts: [event.workout]);
    } else {
      List<Workout> copiedWorkouts = copiedState[date]!.workouts;
      copiedWorkouts.add(event.workout);
      copiedState[date] = copiedState[date]!.copyWith(workouts: copiedWorkouts);
    }

    emit(CurrentRoutinState(routine: copiedState));
  }
}

// event
abstract class RoutineEvent extends Equatable {}

class CreateRoutineEvent extends RoutineEvent {
  final DateTime date;
  final Workout workout;

  CreateRoutineEvent({required this.date, required this.workout});

  @override
  List<Object?> get props => [date, workout];
}

// state
abstract class RoutineState extends Equatable {
  final Map<String, Routine> routine;

  const RoutineState({required this.routine});
}

class InitRoutineState extends RoutineState {
  InitRoutineState() : super(routine: {});

  @override
  List<Object?> get props => [routine];
}

class CurrentRoutinState extends RoutineState {
  const CurrentRoutinState({required super.routine});

  @override
  List<Object?> get props => [routine];
}
