import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/repositories/hive_provider.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(InitRoutineState()) {
    on<RoutineEvent>((event, emit) async {
      if (event is InitRoutineEvent) {
        await _initRoutine(event, emit);
      } else if (event is CreateWorkoutEvent) {
        await _createWorkout(event, emit);
      } else if (event is DeleteWorkoutEvent) {
        await _deleteWorkout(event, emit);
      } else if (event is ModifyWorkoutEvent) {
        await _modifyRoutine(event, emit);
      }
    });
  }

  Future<void> _initRoutine(InitRoutineEvent event, emit) async {
    Map<String, Routine> newState = await HiveProvider().readRoutines();

    emit(CurrentRoutinState(routine: newState));
  }

  Future<void> _createWorkout(CreateWorkoutEvent event, emit) async {
    Map<String, Routine> copiedState = Map.from(state.routine);

    if (copiedState[event.date] == null) {
      copiedState[event.date] =
          Routine(date: event.date, workouts: [event.workout]);
    } else {
      List<Workout> copiedWorkouts = copiedState[event.date]!.workouts;

      copiedWorkouts.add(event.workout);
      copiedState[event.date] =
          copiedState[event.date]!.copyWith(workouts: copiedWorkouts);
    }

    await HiveProvider().writeRoutines(copiedState[event.date]!);

    emit(CurrentRoutinState(routine: copiedState));
  }

  Future<void> _deleteWorkout(DeleteWorkoutEvent event, emit) async {
    Map<String, Routine> copiedState = Map.from(state.routine);
    List<Workout> copiedWorkouts = copiedState[event.date]!.workouts;

    copiedWorkouts.removeWhere((e) => e.name == event.name);
    copiedState[event.date] =
        copiedState[event.date]!.copyWith(workouts: copiedWorkouts);

    await HiveProvider().writeRoutines(copiedState[event.date]!);

    emit(CurrentRoutinState(routine: copiedState));
  }

  Future<void> _modifyRoutine(ModifyWorkoutEvent event, emit) async {
    Map<String, Routine> copiedState = Map.from(state.routine);

    int idx = copiedState[event.date]!
        .workouts
        .indexWhere((element) => element.name == event.workout.name);

    List<Workout> copiedWorkouts = List.from(copiedState[event.date]!.workouts);
    copiedWorkouts[idx] = event.workout;
    copiedState[event.date] =
        copiedState[event.date]!.copyWith(workouts: copiedWorkouts);

    await HiveProvider().writeRoutines(copiedState[event.date]!);

    emit(CurrentRoutinState(routine: copiedState));
  }
}

// event
abstract class RoutineEvent extends Equatable {}

class InitRoutineEvent extends RoutineEvent {
  InitRoutineEvent();

  @override
  List<Object?> get props => [];
}

class CreateWorkoutEvent extends RoutineEvent {
  final String date;
  final Workout workout;

  CreateWorkoutEvent({required this.date, required this.workout});

  @override
  List<Object?> get props => [date, workout];
}

class DeleteWorkoutEvent extends RoutineEvent {
  final String date;
  final String name;

  DeleteWorkoutEvent({required this.date, required this.name});

  @override
  List<Object?> get props => [date, name];
}

class ModifyWorkoutEvent extends RoutineEvent {
  final String date;
  final Workout workout;

  ModifyWorkoutEvent({required this.date, required this.workout});

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
