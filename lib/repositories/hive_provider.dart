import 'package:gymmy_client/models/routine.dart';
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
}
