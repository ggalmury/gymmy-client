import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
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
    foreArms,
    core
  ];

  late TextEditingController textEditingController;
  late List<MapEntry<String, Map<String, dynamic>>> currentWorkoutList;
  late String currentTarget;

  void setCurrentList(String t) {
    setState(() {
      currentTarget = t;
      currentWorkoutList = t == targets[0]
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
    textEditingController = TextEditingController();
    currentTarget = targets[0];
    currentWorkoutList = workouts.entries.toList();
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
        disablePaddingTop: true,
        child: Column(
          children: [
            SearchInput(
              controller: textEditingController,
              prefixIcon: Icons.search,
              hintText: "추가하고 싶은 운동을 검색해 주세요.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: targets.map(
                    (t) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ToggleBtn(
                          label: t,
                          toggle: currentTarget == t,
                          onPressed: () => setCurrentList(t),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentWorkoutList.length,
                itemBuilder: (context, index) {
                  return _WorkoutContainer(workout: currentWorkoutList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutContainer extends StatefulWidget {
  final MapEntry<String, Map<String, dynamic>> workout;

  const _WorkoutContainer({super.key, required this.workout});

  @override
  State<_WorkoutContainer> createState() => __WorkoutContainerState();
}

class __WorkoutContainerState extends State<_WorkoutContainer> {
  bool _updateToggle = false;

  void _setUpdateToggle() {
    setState(() {
      _updateToggle = !_updateToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _setUpdateToggle,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColor.grey2, width: 2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: AppColor.grey2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRect(
                              child: Image.asset(
                                "assets/images/exercise/${widget.workout.value["imgSrc"]}.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          widget.workout.key,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const Icon(Icons.favorite_border)
                  ],
                ),
              ),
              AnimatedContainer(
                width: double.infinity,
                height: _updateToggle ? 50 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryBtn(
                        label: "루틴에 추가하기",
                        onPressed: () {},
                        widgetColor: WidgetColor.appColor,
                        widgetSize: WidgetSize.small,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
