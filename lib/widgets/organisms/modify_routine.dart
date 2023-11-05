import 'package:flutter/material.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/models/workout.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/utils/enum/widget.dart';
import 'package:gymmy_client/widgets/atoms/buttons/primary_btn.dart';
import 'package:gymmy_client/widgets/atoms/inputs/default_input.dart';

class ModifyRoutine extends StatefulWidget {
  final Workout workout;
  final Function(Workout) onSubmit;

  const ModifyRoutine(
      {super.key, required this.workout, required this.onSubmit});

  @override
  State<ModifyRoutine> createState() => _ModifyRoutineState();
}

class _ModifyRoutineState extends State<ModifyRoutine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.workout.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  widget.workout.sets.length,
                  (idx) =>
                      _SetsRow(setCount: idx, sets: widget.workout.sets[idx]),
                ),
              ),
            ),
          ),
          PrimaryBtn(
            label: "등록하기",
            onPressed: () => widget.onSubmit(widget.workout),
            widgetColor: WidgetColor.appColor,
            widgetSize: WidgetSize.big,
          )
        ],
      ),
    );
  }
}

class _SetsRow extends StatefulWidget {
  final int setCount;
  final Sets sets;

  const _SetsRow({super.key, required this.setCount, required this.sets});

  @override
  State<_SetsRow> createState() => __SetsRowState();
}

class __SetsRowState extends State<_SetsRow> {
  late TextEditingController _countController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _countController =
        TextEditingController(text: widget.sets.count.toString());
    _weightController =
        TextEditingController(text: widget.sets.weight.toString());
  }

  @override
  void dispose() {
    _countController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.grey1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.setCount} 세트"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      DefaultInput(
                        controller: _countController,
                        width: 100,
                        keyboardType: TextInputType.number,
                      ),
                      const Text("회"),
                    ],
                  ),
                  Row(
                    children: [
                      DefaultInput(
                        controller: _weightController,
                        width: 100,
                        keyboardType: TextInputType.number,
                      ),
                      const Text("kg"),
                    ],
                  ),
                  const Icon(Icons.delete),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
