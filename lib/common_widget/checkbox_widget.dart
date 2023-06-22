import 'package:flutter/material.dart';
import 'package:test_flutter_ver1/constants/constants.dart';

class CheckBoxWidget extends StatelessWidget {
  final String name;
  final void Function(bool value) onTap;
  final bool value;
  const CheckBoxWidget({
    key,
    this.name,
    this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onTap,
          visualDensity: VisualDensity.comfortable,
        ),
        Text(
          name,
          style: AppThemes.text1,
        ),
      ],
    );
  }
}
