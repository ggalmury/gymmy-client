import 'package:flutter/material.dart';
import 'package:gymmy_client/properties/app_color.dart';

class AppTabBar extends StatelessWidget {
  final List<String> tabs;

  const AppTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
      labelPadding: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.appColor,
            width: 2.0,
          ),
        ),
      ),
      tabs: tabs.map((t) => Text(t)).toList(),
    );
  }
}
