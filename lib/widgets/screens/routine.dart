import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/buttons/text_btn.dart';
import 'package:gymmy_client/widgets/molecules/svg_row.dart';
import 'package:gymmy_client/widgets/organisms/app_calendar.dart';
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
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: RichText(
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            6,
            (index) {
              return const Column(
                children: [
                  _PlanContainer(),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PlanContainer extends StatefulWidget {
  const _PlanContainer({super.key});

  @override
  State<_PlanContainer> createState() => __PlanContainertate();
}

class __PlanContainertate extends State<_PlanContainer> {
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
          color: AppColor.grey1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRect(
                          child: Image.asset(
                            "assets/image/bench-press.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "벤치프레스",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "가슴",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
              const SizedBox(height: 10),
              AnimatedContainer(
                width: double.infinity,
                height: _updateToggle ? 60 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Row(
                  children: [
                    Expanded(
                      child: TextBtn(
                        label: "삭제",
                        onPressed: () {},
                        fontColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryBtn(
                        label: "정보",
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
