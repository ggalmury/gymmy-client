import 'package:flutter/material.dart';
import 'package:gymmy_client/widgets/molecules/app_tabbar.dart';
import 'package:gymmy_client/widgets/templates/set_plan.dart';
import 'package:gymmy_client/widgets/templates/workout_list.dart';
import 'package:gymmy_client/widgets/layouts/base.dart';

class RoutineCreate extends StatelessWidget {
  final List<String> _tabBar = ["오늘의 플랜", "운동 목록"];

  RoutineCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Base(
        title: "루틴 추가하기",
        disablePaddingTop: true,
        child: DefaultTabController(
          length: _tabBar.length,
          child: Column(
            children: [
              AppTabBar(tabs: _tabBar),
              const Expanded(
                child: TabBarView(
                  children: [
                    SetPlan(),
                    WorkoutList(),
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
