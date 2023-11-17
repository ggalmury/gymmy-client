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
                        child: Text("아직 계획된 운동이 없어요😢"),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
