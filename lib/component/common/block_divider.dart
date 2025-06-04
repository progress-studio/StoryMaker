import 'package:flutter/material.dart';
import '../../../core/story_convertible.dart';
import '../../../core/drag_data.dart';

class BlockDivider extends StatefulWidget {
  final VoidCallback onPressed;
  final DragTargetAcceptWithDetails<DraggableItemData> onDrag;

  const BlockDivider({
    super.key,
    required this.onPressed,
    required this.onDrag,
  });

  @override
  State<BlockDivider> createState() => _BlockDividerState();
}

class _BlockDividerState extends State<BlockDivider> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<DraggableItemData>(
      hitTestBehavior: HitTestBehavior.opaque,
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return SizedBox(
          height: 10,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: isHovered ? 1.0 : 0.3,
              duration: const Duration(milliseconds: 150),
              child: Container(
                height: 2,
                width: double.infinity,
                color: isHovered ? Colors.blue.shade300 : Colors.grey.shade400,
              ),
            ),
          ),
        );
      },
      onAcceptWithDetails: widget.onDrag,
    );
  }
}
