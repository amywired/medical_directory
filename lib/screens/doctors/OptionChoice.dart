import 'package:flutter/material.dart';

Widget buildOption(
    {required String title,
    required bool value,
    required Function(bool?) onChanged ,}) {
  return Expanded(
      child: GestureDetector(
    onTap: () {
      onChanged(!value);
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value
              ? const Color.fromARGB(255, 170, 194, 214)
              : Colors.grey.shade700,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
              value: value, onChanged: onChanged, activeColor: Colors.blue),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ));
}
