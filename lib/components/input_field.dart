import 'package:flutter/material.dart';
import 'package:todo/shared/globals.dart';

class InputTextField extends StatelessWidget {
  final double? width;
  final String label;
  final String? hintText;
  final Icon? icon;
  final bool? obscureText;
  final Function(String)? onChanged;
  const InputTextField(
      {Key? key,
      required this.label,
      this.hintText,
      this.icon,
      this.width,
      this.obscureText,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        obscureText: obscureText ?? false,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          filled: true,
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: kPrimaryColor.withOpacity(0.3), width: 1),
          ),
          prefixIcon: icon,
          prefixIconColor: kPrimaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kPrimaryColor, width: 2),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
