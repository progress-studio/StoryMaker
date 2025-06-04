import 'package:flutter/material.dart';
import 'package:storymaker/core/drag_data.dart';

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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          final isHovered = candidateData.isNotEmpty;
          return AnimatedOpacity(
            opacity: _isHovered ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 150),
            child: GestureDetector(
              onTap: widget.onPressed,
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                height: 24,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 2,
                          color:
                          isHovered
                              ? Colors.blue.shade300
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        onAcceptWithDetails: widget.onDrag,
      ),
    );
  }
}