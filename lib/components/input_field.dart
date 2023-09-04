import 'package:flutter/material.dart';
import 'package:todo/shared/globals.dart';

class InputTextField extends StatefulWidget {
  final double? width;
  final String label;
  final String? hintText;
  final Icon? icon;
  final Icon? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  const InputTextField(
      {Key? key,
      required this.label,
      this.hintText,
      this.icon,
      this.width,
      this.obscureText = false,
      this.controller,
      this.suffixIcon,
      this.hintStyle,
      this.fillColor,
      this.maxLines,
      this.onChanged,
      this.onTap})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isVisible = false;

  @override
  initState() {
    super.initState();
    _isVisible = widget.obscureText;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.obscureText
            ? TextInputType.text
            : TextInputType.emailAddress,
        obscureText: _isVisible,
        cursorColor: kPrimaryColor,
        onTap: widget.onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          labelText: widget.label,
          labelStyle: widget.hintStyle,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: kPrimaryColor.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kPrimaryColor, width: 2),
          ),
          prefixIcon: widget.icon,
          prefixIconColor: kPrimaryColor,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  child: _isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
        ),
        maxLines: widget.maxLines ?? 1,
        onChanged: widget.onChanged,
      ),
    );
  }
}
