import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';
import 'package:gymmy_client/widgets/molecules/app_alert.dart';
import 'package:gymmy_client/widgets/molecules/btn_row.dart';
import 'package:gymmy_client/widgets/templates/modify_sets.dart';

class RegisteredWorkoutContainer extends StatefulWidget {
  final Workout workout;

  const RegisteredWorkoutContainer({super.key, required this.workout});

  @override
  State<RegisteredWorkoutContainer> createState() =>
      _RegisteredWorkoutContainerState();
}

class _RegisteredWorkoutContainerState
    extends State<RegisteredWorkoutContainer> {
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
      pageBuilder: (context, _, __) => ModifySets(workout: widget.workout),
    );
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (context) => AppAlert(
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
                child: BtnRow(
                  submitLabel: "정보",
                  cancelLabel: "삭제",
                  onSubmit: _onModify,
                  onCancel: _onDelete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
