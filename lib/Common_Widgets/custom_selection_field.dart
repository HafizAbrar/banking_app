import 'package:flutter/material.dart';

class CustomSelectionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTapSuffix;

  const CustomSelectionField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onTapSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  onPressed: onTapSuffix,
                ),
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
