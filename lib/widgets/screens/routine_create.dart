import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/toggle_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/search_input.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';
import 'package:gymmy_client/widgets/molecules/app_tabbar.dart';
import 'package:gymmy_client/widgets/molecules/modify_sets_row.dart';
import 'package:gymmy_client/widgets/templates/base.dart';

class RoutineCreate extends StatefulWidget {
  final DateTime date;

  const RoutineCreate({super.key, required this.date});

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

  void _pushWorkoutToList(Workout w) {
    context
        .read<RoutineBloc>()
        .add(CreateRoutineEvent(date: widget.date, workout: w));

    showDialog(
      context: context,
      builder: (context) => AlertModal(
        title: "루틴이 추가되었습니다.",
        subTitle: w.name,
        submitBtnLabel: "확인",
      ),
    );
  }

  void _openBottomSheet(String n) {
    // TODO: exception handling

    ScreenUtil.bottomSheetHandler(
      context,
      _BottomSheetBody(
        workout: Workout(name: n),
        onSubmit: _pushWorkoutToList,
      ),
      height: 400,
    );
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
                            itemCount: _currentWorkoutList.length,
                            itemBuilder: (context, index) {
                              return _WorkoutContainer(
                                workout: _currentWorkoutList[index],
                                onTap: _openBottomSheet,
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

class _WorkoutContainer extends StatelessWidget {
  final MapEntry<String, Map<String, dynamic>> workout;
  final Function(String) onTap;

  const _WorkoutContainer(
      {super.key, required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(workout.key),
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
                                "assets/images/exercise/${workout.value["imgSrc"]}.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          workout.key,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const Icon(Icons.add)
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

class _BottomSheetBody extends StatefulWidget {
  final Workout workout;
  final Function(Workout) onSubmit;

  const _BottomSheetBody(
      {super.key, required this.workout, required this.onSubmit});

  @override
  State<_BottomSheetBody> createState() => __BottomSheetBodyState();
}

class __BottomSheetBodyState extends State<_BottomSheetBody> {
  late List<TextEditingController> _countControllers;
  late List<TextEditingController> _weightControllers;

  @override
  void initState() {
    super.initState();
    _countControllers = List.generate(
        widget.workout.sets.length,
        (index) => TextEditingController(
            text: widget.workout.sets[index].count.toString()));
    _weightControllers = List.generate(
        widget.workout.sets.length,
        (index) => TextEditingController(
            text: widget.workout.sets[index].weight.toString()));
  }

  @override
  void dispose() {
    for (TextEditingController c in _countControllers) {
      c.dispose();
    }

    for (TextEditingController c in _weightControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.workout.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  widget.workout.sets.length,
                  (idx) => ModifySetsRow(
                    setCount: idx,
                    sets: widget.workout.sets[idx],
                    countController: _countControllers[idx],
                    weightController: _weightControllers[idx],
                  ),
                ),
              ),
            ),
          ),
          PrimaryBtn(
            label: "추가하기",
            onPressed: () => widget.onSubmit(widget.workout),
            widgetColor: WidgetColor.appColor,
            widgetSize: WidgetSize.big,
          )
        ],
      ),
    );
  }
}
