import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/molecules/registered_workout_container.dart';
import 'package:gymmy_client/widgets/screens/routine_create.dart';
import 'package:intl/intl.dart';

class RoutineInfo extends StatelessWidget {
  const RoutineInfo({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = context.read<SelectedDateBloc>().state.selectedDate;

    return BlocBuilder<SelectedDateBloc, SelectedDateState>(
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
                              text: DateFormat("MM.dd").format(date),
                              style: const TextStyle(color: AppColor.appColor)),
                          const TextSpan(text: " 의 운동"),
                        ],
                        style: const TextStyle(
                          fontSize: 20,
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
                          builder: (BuildContext context) => RoutineCreate(),
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
                              RegisteredWorkoutContainer(
                                workout: workoutList[idx],
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                        "아직 계획된 운동이 없어요😢",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
