import 'package:flutter/material.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/toggle_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/search_input.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';
import 'package:gymmy_client/widgets/molecules/app_tabbar.dart';
import 'package:gymmy_client/widgets/organisms/modify_routine.dart';
import 'package:gymmy_client/widgets/templates/base.dart';

class RoutineCreate extends StatefulWidget {
  const RoutineCreate({super.key});

  @override
  State<RoutineCreate> createState() => _RoutineCreateState();
}

class _RoutineCreateState extends State<RoutineCreate> {
  final List<String> _tabBar = ["루틴 목록", "오늘의 플랜"];
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

  void _pushWorkoutToList(Workout w) {
    // TODO: implement

    showDialog(
      context: context,
      builder: (context) => AlertModal(
        title: "루틴이 추가되었습니다.",
        subTitle: w.name,
        submitBtnLabel: "확인",
      ),
    );
  }

  void _removeWorkoutToList(String w) {
    // TODO: implement

    showDialog(
      context: context,
      builder: (context) => AlertModal(
        title: "루틴이 되었습니다.",
        subTitle: w,
        submitBtnLabel: "확인",
      ),
    );
  }

  void _onAddRoutineBottomSheet(String n) {
    // TODO: exception handling

    ScreenUtil.bottomSheetHandler(
      context,
      ModifyRoutine(
        workout: Workout(name: n),
        onSubmit: _pushWorkoutToList,
      ),
      height: 400,
    );
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
                                onTap: () => _onAddRoutineBottomSheet(
                                    currentWorkoutList[index].key),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text("sadf"),
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
  final VoidCallback onTap;

  const _WorkoutContainer(
      {super.key, required this.workout, required this.onTap});

  @override
  State<_WorkoutContainer> createState() => __WorkoutContainerState();
}

class __WorkoutContainerState extends State<_WorkoutContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
            ],
          ),
        ),
      ),
    );
  }
}
