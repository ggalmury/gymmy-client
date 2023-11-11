import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';
import 'package:gymmy_client/widgets/molecules/svg_row.dart';
import 'package:gymmy_client/widgets/organisms/app_calendar.dart';
import 'package:gymmy_client/widgets/organisms/modify_sets_dialog.dart';
import 'package:gymmy_client/widgets/screens/routine_create.dart';
import 'package:gymmy_client/widgets/templates/base.dart';

class Routine extends StatelessWidget {
  const Routine({super.key});

  @override
  Widget build(BuildContext context) {
    return Base(
      title: "데일리 루틴",
      child: Column(
        children: [
          const AppCalendar(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.grey1,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<SelectedDateBloc, SelectedDateState>(
                  builder: (context, state) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: DateFormat("MM.dd")
                                          .format(state.selectedDate),
                                      style: const TextStyle(
                                        color: AppColor.appColor,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " 의 운동",
                                    ),
                                  ],
                                ),
                              )),
                          const Text(
                            "진행중🔥",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgRow(
                            label: "헬스",
                            svgName: "dumbell",
                          ),
                          SvgRow(
                            label: "1시간",
                            svgName: "clock",
                          ),
                        ],
                      ),
                      PrimaryBtn(
                        label: "자세히 보기",
                        onPressed: () => ScreenUtil.bottomSheetHandler(
                          context,
                          const _BottomSheetBody(),
                        ),
                        widgetColor: WidgetColor.appColor,
                        widgetSize: WidgetSize.big,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomSheetBody extends StatelessWidget {
  const _BottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SelectedDateBloc, SelectedDateState>(
        builder: (context, dateState) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: DateUtil.compareTo(
                                      DateTime.now(), dateState.selectedDate)
                                  ? "오늘"
                                  : DateFormat("M월 d일")
                                      .format(dateState.selectedDate),
                              style: const TextStyle(color: AppColor.appColor),
                            ),
                            const TextSpan(text: "은"),
                            const TextSpan(
                              text: " 가슴",
                              style: TextStyle(color: AppColor.appColor),
                            ),
                            const TextSpan(text: " 하는날🔥"),
                          ],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "13:00",
                              style: TextStyle(color: AppColor.appColor),
                            ),
                            TextSpan(text: " 부터 "),
                            TextSpan(
                              text: "14:00",
                              style: TextStyle(color: AppColor.appColor),
                            ),
                            TextSpan(text: " 까지"),
                          ],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "1시간",
                              style: TextStyle(color: AppColor.appColor),
                            ),
                            TextSpan(text: " 동안 열심히 운동할 예정이에요."),
                          ],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      PrimaryBtn(
                        label: "루틴 추가하기",
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RoutineCreate(),
                          ),
                        ),
                        widgetColor: WidgetColor.appColor,
                        widgetSize: WidgetSize.big,
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: BlocBuilder<RoutineBloc, RoutineState>(
              builder: (context, state) {
                List<Workout>? workoutList = state
                    .routine[DateUtil.formatToYMD(dateState.selectedDate)]
                    ?.workouts;

                return workoutList != null && workoutList.isNotEmpty
                    ? Column(
                        children: List.generate(
                          workoutList.length,
                          (idx) {
                            return Column(
                              children: [
                                _WorkoutContainer(
                                  workout: workoutList[idx],
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text("아직 계획된 루틴이 없어요😢"),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkoutContainer extends StatefulWidget {
  final Workout workout;

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

  void _onModify() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, _, __) =>
          ModifySetsDialog(workout: widget.workout),
    );
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertModal(
        title: "루틴을 삭제할까요?",
        cancelable: true,
        onConfirm: () => context.read<RoutineBloc>().add(DeleteWorkoutEvent(
            date: DateUtil.formatToYMD(
                context.read<SelectedDateBloc>().state.selectedDate),
            name: widget.workout.name)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> workOutValue = workouts[widget.workout.name]!;

    return GestureDetector(
      onTap: _setUpdateToggle,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColor.grey1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRect(
                          child: Image.asset(
                            "assets/images/exercise/${workOutValue["imgSrc"]}.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.workout.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: List.generate(
                                (workOutValue["target"] as List<String>).length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.grey3,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Text(
                                          workOutValue["target"][index],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      _updateToggle
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 25,
                    ),
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
                      child: TextBtn(
                        label: "삭제",
                        onPressed: _onDelete,
                        fontColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryBtn(
                        label: "정보",
                        onPressed: _onModify,
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
