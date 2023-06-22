import 'package:flutter/material.dart';
import 'package:test_flutter_ver1/constants/constants.dart';
import 'package:test_flutter_ver1/extensions/extensions.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String value) onChanged;
  final TextEditingController controller;

  final TextInputType keyboardType;
  const InputTextField({
    Key key,
    this.labelText,
     this.hintText,
     this.onChanged,
     this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) Text(labelText, style: AppThemes.headline3),
        Gap.h8,
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          style: AppThemes.text1,
          decoration: InputDecoration(
            fillColor: AppThemes.lightGrey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.p20),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.p16,
              vertical: Sizes.p12,
            ),
            hintText: hintText,
            hintStyle: AppThemes.text1.grey,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
