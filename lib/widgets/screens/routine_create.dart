import 'package:flutter/material.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/toggle_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/search_input.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';
import 'package:gymmy_client/widgets/molecules/app_tabbar.dart';
import 'package:gymmy_client/widgets/templates/base.dart';

class RoutineCreate extends StatefulWidget {
  const RoutineCreate({super.key});

  @override
  State<RoutineCreate> createState() => _RoutineCreateState();
}

class _RoutineCreateState extends State<RoutineCreate> {
  final List<String> _tabBar = ["루틴 목록", "추가된 루틴"];
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

  final List<Workout> addedWorkoutList = [];
  late TextEditingController textEditingController;
  late List<MapEntry<String, Map<String, dynamic>>> currentWorkoutList;
  late String currentTarget;

  void _setCurrentWorkoutList(String t) {
    setState(() {
      currentTarget = t;
      currentWorkoutList = t == _targets[0]
          ? workouts.entries.toList()
          : workouts.entries
              .where((entry) =>
                  (entry.value['target'] as List<String>).contains(t))
              .toList();
    });
  }

  void _pushWorkoutToList(String w) {
    if (addedWorkoutList.any((element) => element.name == w)) {
      showDialog(
        context: context,
        builder: (context) => const AlertModal(
          title: "이미 존재하는 루틴입니다.",
          submitBtnLabel: "확인",
        ),
      );
      return;
    }

    setState(() {
      addedWorkoutList.add(Workout(name: w));
    });
  }

  void _removeWorkoutToList(String w) {
    setState(() {
      addedWorkoutList.removeWhere((element) => element.name == w);
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    currentTarget = _targets[0];
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
        child: DefaultTabController(
          length: _tabBar.length,
          child: Column(
            children: [
              AppTabBar(tabs: _tabBar),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        SearchInput(
                          controller: textEditingController,
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
                                      toggle: currentTarget == t,
                                      onPressed: () =>
                                          _setCurrentWorkoutList(t),
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
                              return _WorkoutContainer(
                                workout: currentWorkoutList[index],
                                onPressed: _pushWorkoutToList,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: addedWorkoutList.map(
                          (e) {
                            return Container(
                              color: AppColor.grey2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.name),
                                  GestureDetector(
                                    onTap: () => _removeWorkoutToList(e.name),
                                    child: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
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

class _WorkoutContainer extends StatefulWidget {
  final MapEntry<String, Map<String, dynamic>> workout;
  final Function(String) onPressed;

  const _WorkoutContainer(
      {super.key, required this.workout, required this.onPressed});

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
                height: _updateToggle ? 60 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryBtn(
                        label: "루틴에 추가하기",
                        onPressed: () => widget.onPressed(widget.workout.key),
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
