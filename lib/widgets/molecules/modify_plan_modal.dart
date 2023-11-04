import 'package:flutter/material.dart';

class ModifyPlanModal extends StatefulWidget {
  const ModifyPlanModal({super.key});

  @override
  State<ModifyPlanModal> createState() => _ModifyPlanModalState();
}

class _ModifyPlanModalState extends State<ModifyPlanModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
