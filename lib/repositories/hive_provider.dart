import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

const String boxName = "routine";

class HiveProvider {
  static final HiveProvider _instance = HiveProvider._internal();
  late BoxCollection _collection;
  late CollectionBox<Routine> _box;

  factory HiveProvider() {
    return _instance;
  }

  HiveProvider._internal();

  init() async {
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    _registerAdapter();

    _collection =
        await BoxCollection.open("gymmy", {boxName}, path: directory.path);
    _box = await _collection.openBox<Routine>(boxName);
  }

  _registerAdapter() {
    Hive.registerAdapter(RoutineAdapter());
    Hive.registerAdapter(WorkoutAdapter());
    Hive.registerAdapter(SetsAdapter());
  }

  Future<Map<String, Routine>> readRoutines() async {
    return await _box.getAllValues();
  }

  Future<void> writeRoutines(Routine routine) async {
    await _box.put(routine.date, routine);
  }
}
