import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/repositories/hive_provider.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(InitRoutineState()) {
    on<RoutineEvent>((event, emit) async {
      if (event is InitRoutineEvent) {
        await _initRoutine(event, emit);
      } else if (event is CreateWorkoutEvent) {
        await _createWorkout(event, emit);
      } else if (event is ModifyRoutineEvent) {
        _modifyRoutine(event, emit);
      }
    });
  }

  Future<void> _initRoutine(InitRoutineEvent event, emit) async {
    Map<String, Routine> newState = {};
    List<Routine> routineList = await HiveProvider().readRoutines();

    for (Routine r in routineList) {
      newState[r.date] = r;
    }

    emit(CurrentRoutinState(routine: newState));
  }

  Future<void> _createWorkout(CreateWorkoutEvent event, emit) async {
    Map<String, Routine> copiedState = Map.from(state.routine);

    if (copiedState[event.date] == null) {
      copiedState[event.date] =
          Routine(date: event.date, target: "가슴", workouts: [event.workout]);
    } else {
      List<Workout> copiedWorkouts = copiedState[event.date]!.workouts;

      copiedWorkouts.add(event.workout);
      copiedState[event.date] =
          copiedState[event.date]!.copyWith(workouts: copiedWorkouts);
    }

    await HiveProvider().writeRoutines(copiedState[event.date]!);

    emit(CurrentRoutinState(routine: copiedState));
  }

  void _modifyRoutine(ModifyRoutineEvent event, emit) {
    Map<String, Routine> copiedState = Map.from(state.routine);
    String date = DateUtil.formatToYMD(event.date);
    int idx = copiedState[date]!
        .workouts
        .indexWhere((element) => element.name == event.workout.name);

    List<Workout> copiedWorkouts = List.from(copiedState[date]!.workouts);
    copiedWorkouts[idx] = event.workout;
    copiedState[date] = copiedState[date]!.copyWith(workouts: copiedWorkouts);

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

class ModifyRoutineEvent extends RoutineEvent {
  final DateTime date;
  final Workout workout;

  ModifyRoutineEvent({required this.date, required this.workout});

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
