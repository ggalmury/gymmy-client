import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/constant.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';
import 'package:gymmy_client/widgets/molecules/svg_row.dart';
import 'package:gymmy_client/widgets/organisms/app_calendar.dart';
import 'package:gymmy_client/widgets/screens/routine_create.dart';
import 'package:gymmy_client/widgets/templates/base.dart';
import 'package:intl/intl.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  DateTime selectedDate = DateTime.now();

  void _onDaySelected(DateTime s) {
    setState(() {
      selectedDate = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Base(
      title: "데일리 루틴",
      child: Column(
        children: [
          AppCalendar(
            selectedDate: selectedDate,
            onDaySelected: _onDaySelected,
          ),
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
                child: Column(
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
                                  text:
                                      DateFormat("MM.dd").format(selectedDate),
                                  style: const TextStyle(
                                    color: AppColor.appColor,
                                  ),
                                ),
                                const TextSpan(
                                  text: " 의 운동",
                                ),
                              ],
                            ),
                          ),
                        ),
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
                        _BottomSheetBody(),
                      ),
                      widgetColor: WidgetColor.appColor,
                      widgetSize: WidgetSize.big,
                    )
                  ],
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
  final List<String> workOutList = ["벤치 프레스", "데드리프트", "스쿼트"];

  _BottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: "오늘은 "),
                          TextSpan(
                            text: "가슴",
                            style: TextStyle(color: AppColor.appColor),
                          ),
                          TextSpan(text: " 하는날🔥"),
                        ],
                        style: TextStyle(
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
                      onPressed: () => Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
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
          child: Column(
            children: List.generate(
              workOutList.length,
              (index) {
                return Column(
                  children: [
                    _PlanContainer(
                      workoutName: workOutList[index],
                      onUpdate: () {},
                      onDelete: () => ScreenUtil.alertModalHandler(
                          context, "루틴을 삭제할까요?",
                          cancelable: true),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanContainer extends StatefulWidget {
  final String workoutName;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const _PlanContainer(
      {super.key,
      required this.workoutName,
      required this.onUpdate,
      required this.onDelete});

  @override
  State<_PlanContainer> createState() => __PlanContainerState();
}

class __PlanContainerState extends State<_PlanContainer> {
  bool _updateToggle = false;

  void _setUpdateToggle() {
    setState(() {
      _updateToggle = !_updateToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> workOutValue = workouts[widget.workoutName]!;

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
                              widget.workoutName,
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
                        onPressed: widget.onDelete,
                        fontColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryBtn(
                        label: "정보",
                        onPressed: widget.onUpdate,
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
