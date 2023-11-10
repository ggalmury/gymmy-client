import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String boxName = "routine";

class HiveProvider {
  static final HiveProvider _instance = HiveProvider._internal();
  late Box<Routine> box;

  factory HiveProvider() {
    return _instance;
  }

  HiveProvider._internal();

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RoutineAdapter());
    Hive.registerAdapter(WorkoutAdapter());
    Hive.registerAdapter(SetsAdapter());
  }

  _open() async {
    box = await Hive.openBox<Routine>(boxName);
  }

  _close() async {
    await box.close();
  }

  Future<List<Routine>> readRoutines() async {
    await _open();
    List<Routine> result = box.values.toList();
    await _close();

    return result;
  }

  Future<void> writeRoutines(Routine routine) async {
    await _open();
    int idx = box.values.toList().indexWhere((e) => e.date == routine.date);

    if (idx != -1) {
      await box.deleteAt(idx);
    }

    await box.add(routine);
    await _close();
  }
}
