import 'package:flutter/material.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/widgets/atoms/buttons/toggle_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/primary_input.dart';
import 'package:gymmy_client/widgets/molecules/workout_container.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  final List<String> _targets = [
    "전체",
    wholeBody,
    legs,
    back,
    chest,
    shoulders,
    biceps,
    triceps,
    foreArms,
    core
  ];

  late TextEditingController _textEditingController;
  late List<MapEntry<String, Map<String, dynamic>>> _currentWorkoutList;
  late String _currentTarget;

  void _setCurrentWorkoutList(String t) {
    setState(() {
      _currentTarget = t;
      _currentWorkoutList = t == _targets[0]
          ? workouts.entries.toList()
          : workouts.entries
              .where((entry) =>
                  (entry.value['target'] as List<String>).contains(t))
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _currentTarget = _targets[0];
    _currentWorkoutList = workouts.entries.toList();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryInput(
          controller: _textEditingController,
          prefixIcon: Icons.search,
          hintText: "추가하고 싶은 운동을 검색해 주세요.",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _targets.map(
                (t) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ToggleBtn(
                      label: t,
                      toggle: _currentTarget == t,
                      onPressed: () => _setCurrentWorkoutList(t),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _currentWorkoutList.length,
            itemBuilder: (context, index) {
              return WorkoutContainer(workout: _currentWorkoutList[index]);
            },
          ),
        ),
      ],
    );
  }
}
