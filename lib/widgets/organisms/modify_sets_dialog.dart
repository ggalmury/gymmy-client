import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/utils/helper/date_util.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/dynamic_input.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';

class ModifySetsDialog extends StatefulWidget {
  final String workoutName;
  final DateTime date;

  const ModifySetsDialog(
      {super.key, required this.workoutName, required this.date});

  @override
  State<ModifySetsDialog> createState() => _ModifySetsDialogState();
}

class _ModifySetsDialogState extends State<ModifySetsDialog> {
  late Workout workout;
  late List<TextEditingController> _countControllers;
  late List<TextEditingController> _weightControllers;

  void _createSet() {
    setState(() {
      workout.sets.add(Sets(count: 10, weight: 10));

      _countControllers
          .add(TextEditingController(text: workout.sets.last.count.toString()));
      _weightControllers.add(
          TextEditingController(text: workout.sets.last.weight.toString()));
    });
  }

  void _deleteSet(int idx) {
    setState(() {
      workout.sets.removeAt(idx);
      _countControllers.removeAt(idx);
      _weightControllers.removeAt(idx);
    });
  }

  void _submit() {
    List<Sets> sets = [];

    for (int i = 0; i < workout.sets.length; i++) {
      try {
        sets.add(Sets(
            count: int.parse(_countControllers[i].text),
            weight: int.parse(_weightControllers[i].text)));
      } on FormatException {
        showDialog(
          context: context,
          builder: (context) => const AlertModal(
            title: "올바른 숫자를 입력해 주세요.",
            submitBtnLabel: "확인",
          ),
        );

        return;
      }
    }

    // TODO: update routine

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    workout = context
        .read<RoutineBloc>()
        .state
        .routine[DateUtil.formatToYMD(widget.date)]!
        .workouts
        .firstWhere((e) => e.name == widget.workoutName);

    _countControllers = List.generate(
        workout.sets.length,
        (index) =>
            TextEditingController(text: workout.sets[index].count.toString()));
    _weightControllers = List.generate(
        workout.sets.length,
        (index) =>
            TextEditingController(text: workout.sets[index].weight.toString()));
  }

  @override
  void dispose() {
    for (TextEditingController c in _countControllers) {
      c.dispose();
    }

    for (TextEditingController c in _weightControllers) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PrimaryBtn(
                        label: "추가",
                        onPressed: _createSet,
                        widgetColor: WidgetColor.appColor,
                        widgetSize: WidgetSize.small,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        workout.sets.length,
                        (index) {
                          return _ModifyRow(
                            index: index,
                            sets: workout.sets[index],
                            countController: _countControllers[index],
                            weightController: _weightControllers[index],
                            onDelete: _deleteSet,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                PrimaryBtn(
                  label: "확인",
                  onPressed: () => _submit(),
                  widgetColor: WidgetColor.appColor,
                  widgetSize: WidgetSize.big,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModifyRow extends StatelessWidget {
  final int index;
  final Sets sets;
  final Function(int) onDelete;
  final TextEditingController countController;
  final TextEditingController weightController;

  const _ModifyRow(
      {super.key,
      required this.index,
      required this.sets,
      required this.onDelete,
      required this.countController,
      required this.weightController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.grey1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1} 세트",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CounterRow(controller: countController, label: "회"),
                  _CounterRow(controller: weightController, label: "kg"),
                  index != 0
                      ? GestureDetector(
                          onTap: () => onDelete(index),
                          child: const Icon(Icons.delete, size: 25),
                        )
                      : const SizedBox(width: 25),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _CounterRow({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DynamicInput(
          controller: controller,
          width: 80,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          borderColor: AppColor.grey3,
        ),
        const SizedBox(width: 15),
        Text(label),
      ],
    );
  }
}
