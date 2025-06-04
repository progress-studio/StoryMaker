import 'package:flutter/material.dart';

import '../../core/story_convertible.dart';
import 'package:story_dart/project.dart';
import '../common/block_divider.dart';
import 'intent_block.dart';
import '../../core/drag_data.dart';

class ChildrenBlock extends StatefulWidget {
  final List<StoryConvertible> storyConvertible;
  final Project project;

  const ChildrenBlock({
    super.key,
    required this.storyConvertible,
    required this.project,
  });

  @override
  ChildrenBlockState createState() => ChildrenBlockState();
}

class ChildrenBlockState extends State<ChildrenBlock> {
  void onDrag(
    DraggableItemData draggableData,
    int targetInsertIndexFromDivider,
  ) {
    final StoryConvertible itemToMove = draggableData.item;
    bool isMovingSameList = identical(
      draggableData.sourceList,
      widget.storyConvertible,
    );

    final originalIndex = widget.storyConvertible.indexOf(itemToMove);
    int finalTargetInsertIndex = targetInsertIndexFromDivider;

    if (isMovingSameList && originalIndex != -1) {
      if (originalIndex < targetInsertIndexFromDivider) {
        finalTargetInsertIndex = originalIndex + 1;
      }
    }

    if (isMovingSameList) {
      setState(() {
        if (originalIndex != -1) {
          final StoryConvertible itemRemoved = widget.storyConvertible.removeAt(
            originalIndex,
          );
          int insertionPoint = finalTargetInsertIndex.clamp(
            0,
            widget.storyConvertible.length,
          );
          widget.storyConvertible.insert(insertionPoint, itemRemoved);
        }
      });
    } else {
      draggableData.removeFromSourceCallback(itemToMove);
      setState(() {
        widget.storyConvertible.removeWhere((e) => e == itemToMove);
        final safeInsertIndex = targetInsertIndexFromDivider.clamp(
          0,
          widget.storyConvertible.length,
        );
        widget.storyConvertible.insert(safeInsertIndex, itemToMove);
      });
    }
  }

  void removeItem(StoryConvertible model) {
    if (widget.storyConvertible.contains(model)) {
      setState(() {
        widget.storyConvertible.remove(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Opacity(
            opacity: 0.1,
            child: VerticalDivider(color: Colors.black, thickness: 2),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        widget.storyConvertible.indexed
                            .map(
                              (entry) => Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  IntentBlock(
                                    key: ObjectKey(entry.$2),
                                    storyConvertible: entry.$2,
                                    project: widget.project,
                                    removeItemCallback: removeItem,
                                    currentList: widget.storyConvertible,
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, -12),
                                    child: BlockDivider(
                                      onPressed: () {},
                                      onDrag: (it) => onDrag(it.data, entry.$1),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 10),
                  child: BlockDivider(
                    onPressed: () {},
                    onDrag:
                        (it) =>
                            onDrag(it.data, widget.storyConvertible.length - 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
