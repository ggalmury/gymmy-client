import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/models/routine.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/molecules/app_alert.dart';

class WorkoutContainer extends StatefulWidget {
  final MapEntry<String, Map<String, dynamic>> workout;

  const WorkoutContainer({super.key, required this.workout});

  @override
  State<WorkoutContainer> createState() => _WorkoutContainerState();
}

class _WorkoutContainerState extends State<WorkoutContainer> {
  bool _updateToggle = false;

  void _setUpdateToggle() {
    setState(() {
      _updateToggle = !_updateToggle;
    });
  }

  void _pushWorkoutToList() {
    DateTime date = context.read<SelectedDateBloc>().state.selectedDate;

    Routine? state =
        context.read<RoutineBloc>().state.routine[DateUtil.formatToYMD(date)];

    if (state != null &&
        state.workouts.where((e) => e.name == widget.workout.key).isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AppAlert(
          title: "이미 추가된 루틴입니다.",
          subTitle: widget.workout.key,
          submitBtnLabel: "확인",
        ),
      );

      return;
    }

    context.read<RoutineBloc>().add(
          CreateWorkoutEvent(
            date: DateUtil.formatToYMD(date),
            workout: Workout(name: widget.workout.key),
          ),
        );

    showDialog(
      context: context,
      builder: (context) => AppAlert(
        title: "루틴이 추가되었습니다.",
        subTitle: widget.workout.key,
        submitBtnLabel: "확인",
      ),
    );
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
                    const Icon(Icons.add)
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
                        onPressed: _pushWorkoutToList,
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
