import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/widgets/organisms/routine_summary.dart';
import 'package:gymmy_client/widgets/organisms/app_calendar.dart';
import 'package:gymmy_client/widgets/layouts/base.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  void initState() {
    super.initState();

    context.read<RoutineBloc>().add(InitRoutineEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const Base(
      title: "데일리 루틴",
      child: Column(
        children: [
          AppCalendar(),
          SizedBox(height: 20),
          Expanded(
            child: RoutineSummary(),
          )
        ],
      ),
    );
  }
}
