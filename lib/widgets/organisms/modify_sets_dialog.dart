import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/dynamic_input.dart';
import 'package:gymmy_client/widgets/molecules/alert_modal.dart';

class ModifySetsDialog extends StatefulWidget {
  final Workout workout;

  const ModifySetsDialog({super.key, required this.workout});

  @override
  State<ModifySetsDialog> createState() => _ModifySetsDialogState();
}

class _ModifySetsDialogState extends State<ModifySetsDialog> {
  late List<Sets> sets;
  late List<TextEditingController> _countControllers;
  late List<TextEditingController> _weightControllers;

  void _createSet() {
    setState(() {
      sets.add(Sets(count: 10, weight: 10));

      _countControllers
          .add(TextEditingController(text: sets.last.count.toString()));

      _weightControllers
          .add(TextEditingController(text: sets.last.weight.toString()));
    });
  }

  void _deleteSet(int idx) {
    setState(() {
      sets.removeAt(idx);
      _countControllers.removeAt(idx);
      _weightControllers.removeAt(idx);
    });
  }

  void _submit() {
    List<Sets> copiedSets = [];

    for (int i = 0; i < sets.length; i++) {
      try {
        copiedSets.add(Sets(
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
    print(copiedSets);
    Workout modifiedWorkout = widget.workout.copyWith(sets: copiedSets);
    DateTime date = context.read<SelectedDateBloc>().state.selectedDate;

    context
        .read<RoutineBloc>()
        .add(ModifyRoutineEvent(date: date, workout: modifiedWorkout));

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    sets = List.from(widget.workout.sets);

    _countControllers = List.generate(sets.length,
        (index) => TextEditingController(text: sets[index].count.toString()));
    _weightControllers = List.generate(sets.length,
        (index) => TextEditingController(text: sets[index].weight.toString()));
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
                        widget.workout.name,
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
                        sets.length,
                        (index) {
                          return _ModifyRow(
                            index: index,
                            sets: sets[index],
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
                  onPressed: _submit,
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
