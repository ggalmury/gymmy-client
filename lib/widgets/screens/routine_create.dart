import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/widgets/atoms/buttons/toggle_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/search_input.dart';
import 'package:gymmy_client/widgets/templates/base.dart';

class RoutineCreate extends StatefulWidget {
  const RoutineCreate({super.key});

  @override
  State<RoutineCreate> createState() => _RoutineCreateState();
}

class _RoutineCreateState extends State<RoutineCreate> {
  final List<String> targets = [
    "전체",
    wholeBody,
    legs,
    back,
    chest,
    shoulders,
    biceps,
    triceps,
    core
  ];
  final List<MapEntry<String, List<String>>> workoutList =
      workouts.entries.map((e) => e).toList();

  late TextEditingController textEditingController;
  late List<MapEntry<String, List<String>>> currentWorkoutList;
  late String currentTarget;

  void setCurrentList(String t) {
    setState(() {
      currentTarget = t;
      currentWorkoutList = t == targets[0]
          ? workoutList
          : workoutList.where((element) => element.value.contains(t)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    currentTarget = targets[0];
    currentWorkoutList = workoutList;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Base(
        title: "루틴 추가하기",
        child: Column(
          children: [
            SearchInput(
              controller: textEditingController,
              prefixIcon: Icons.search,
              hintText: "추가하고 싶은 운동을 검색해 주세요.",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: targets.map((t) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ToggleBtn(
                      label: t,
                      toggle: currentTarget == t,
                      onPressed: () => setCurrentList(t),
                    ),
                  );
                }).toList(),
              ),
            ),
            Column(
              children: currentWorkoutList.map(
                (e) {
                  return Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColor.grey2, width: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRect(
                          child: Image.asset(
                            "assets/images/exercise/${e.key}.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                        Column(
                          children: [
                            Text(e.key),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
