import 'package:flutter/material.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onChanged});

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
