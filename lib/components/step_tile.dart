import 'package:flutter/material.dart';

class StepTile extends StatelessWidget {
  final String stepTitle;
  final bool isCompleted;
  final Function(bool?)? onCheckboxChanged;

  StepTile(
      {required this.stepTitle,
      required this.isCompleted,
      this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stepTitle),
      trailing: Checkbox(
        value: isCompleted,
        onChanged: onCheckboxChanged,
      ),
    );
  }
}
