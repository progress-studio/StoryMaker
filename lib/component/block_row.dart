import 'package:flutter/material.dart';

class BlockRow extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const BlockRow({super.key, required this.title, this.children = const []});

  @override
  State<BlockRow> createState() => _BlockRowState();
}

class _BlockRowState extends State<BlockRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Transform.translate(
            offset: const Offset(-4, 0),
            child: Row(
              children: [
                Opacity(
                  opacity: _isHovered ? 1 : 0.2,
                  child: const Icon(Icons.drag_indicator),
                ),
                Text(widget.title),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        ...widget.children,
      ],
    );
  }
}
