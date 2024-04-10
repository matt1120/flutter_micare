import 'package:flutter/material.dart';
import 'package:flutter_micare/shared/custom_color_code.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomElevatedButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: CustomColorCode.secondaryColor,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
