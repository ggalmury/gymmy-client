import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatelessWidget {
  final Function(DateTime) onDaySelected;
  final DateTime selectedDate;

  const AppCalendar(
      {super.key, required this.selectedDate, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.grey2,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TableCalendar(
          locale: "ko",
          firstDay: DateTime(2020, 1, 1),
          focusedDay: selectedDate,
          lastDay: DateTime(2030, 12, 31),
          onHeaderTapped: (focusedDay) => onDaySelected(DateTime.now()),
          onDaySelected: (selectedDay, focusedDay) =>
              onDaySelected(selectedDay),
          selectedDayPredicate: (d) => isSameDay(selectedDate, d),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: AppColor.appColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: AppColor.appColor,
            ),
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppColor.appColor,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColor.appColorLight,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
