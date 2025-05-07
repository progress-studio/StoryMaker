import 'package:flutter/material.dart';

class BlockTextField extends StatelessWidget {
  final TextEditingController controller;

  const BlockTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
