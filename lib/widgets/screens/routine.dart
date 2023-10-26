import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/screen_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
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
                color: AppColor.grey2,
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
                        const Center(
                          child: Text("바텀시트"),
                        ),
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
