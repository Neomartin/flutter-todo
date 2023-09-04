import 'package:flutter/material.dart';
import 'package:todo/shared/globals.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool outlineButton;
  final void Function()? onPressed;
  final double? width;
  const ButtonWidget({
    required this.label,
    this.outlineButton = false,
    this.onPressed,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: outlineButton ? Colors.transparent : kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // side: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: outlineButton ? kPrimaryColor : Colors.white,
          ),
        ),
      ),
    );
  }
}
