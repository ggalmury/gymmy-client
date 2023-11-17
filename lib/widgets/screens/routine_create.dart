import 'package:flutter/material.dart';
import 'package:gymmy_client/widgets/organisms/workout_list.dart';
import 'package:gymmy_client/widgets/layouts/base.dart';

class RoutineCreate extends StatelessWidget {
  const RoutineCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Base(
        title: "루틴 추가하기",
        disablePaddingTop: true,
        child: WorkoutList(),
      ),
    );
  }
}
