import 'package:flutter/material.dart';
import 'package:storymaker/core/story_convertible.dart';
import '../../core/drag_data.dart';

class BlockRow extends StatefulWidget {
  final String title;
  final StoryConvertible model;
  final Function(StoryConvertible) removeItemCallback;
  final List<Widget> children;
  final List<StoryConvertible> currentList;

  const BlockRow({
    super.key,
    required this.title,
    required this.model,
    required this.removeItemCallback,
    required this.currentList,
    this.children = const [],
  });

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
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Transform.translate(
            offset: const Offset(-4, 0),
            child: Draggable<DraggableItemData>(
              data: DraggableItemData(
                item: widget.model,
                removeFromSourceCallback: widget.removeItemCallback,
                sourceList: widget.currentList,
              ),
              feedback: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Opacity(
                      opacity: 0.5,
                      child: Icon(Icons.drag_indicator),
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              dragAnchorStrategy: pointerDragAnchorStrategy,
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
        ),
        const SizedBox(width: 8),
        ...widget.children,
      ],
    );
  }
}
