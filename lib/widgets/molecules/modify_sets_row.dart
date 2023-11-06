import 'package:flutter/material.dart';
import 'package:gymmy_client/models/sets.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/widgets/atoms/inputs/dynamic_input.dart';

class ModifySetsRow extends StatelessWidget {
  final int setCount;
  final Sets sets;
  final TextEditingController countController;
  final TextEditingController weightController;

  const ModifySetsRow(
      {super.key,
      required this.setCount,
      required this.sets,
      required this.countController,
      required this.weightController});

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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${setCount + 1} 세트",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CounterRow(controller: countController, label: "회"),
                  _CounterRow(controller: weightController, label: "kg"),
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
          width: 70,
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
