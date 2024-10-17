import 'package:flutter/material.dart';
import 'package:quicknote/colors/quicknote_colors.dart';

class TextInputWidget extends StatelessWidget {
  TextInputWidget(
      {super.key,
      this.defaultValue,
      required this.label,
      required this.hintText,
      required this.onChanged,
      this.obscure = false});

  final String? defaultValue;
  final String label;
  final String hintText;
  final void Function(String) onChanged;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                  color: QuicknoteColors.blackShade1,
                ),
              ),
            ),
          ),
          TextField(
            controller: TextEditingController(text: defaultValue),
            obscureText: obscure,
            decoration: InputDecoration(
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
