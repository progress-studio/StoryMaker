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

    // ignore: avoid_print
    print(
      "ChildrenBlockState.onDrag PRE-ADJUST: originalIndex=$originalIndex, targetFromDivider=$targetInsertIndexFromDivider, isMovingSameList=$isMovingSameList, item=${itemToMove.hashCode}",
    );

    if (isMovingSameList && originalIndex != -1) {
      // 위에서 아래로 이동하는 경우 (originalIndex < targetInsertIndexFromDivider)
      // "한 칸 더 내려가는 문제"를 임시로 막기 위해, 실제 목표 인덱스를 originalIndex + 1로 강제.
      // 이는 사용자가 여러 칸 아래로 한 번에 드래그하는 기능을 제한하지만, 현재 버그를 해결하기 위함.
      if (originalIndex < targetInsertIndexFromDivider) {
        finalTargetInsertIndex = originalIndex + 1;
        // ignore: avoid_print
        print(
          "ChildrenBlockState.onDrag ADJUSTED for downward same-list move: finalTargetInsertIndex set to $finalTargetInsertIndex",
        );
      }
      // 위로 이동하는 경우는 targetInsertIndexFromDivider를 그대로 사용 (문제가 없다고 하셨으므로)
    }

    // ignore: avoid_print
    print(
      "ChildrenBlockState.onDrag POST-ADJUST: originalIndex=$originalIndex, finalTargetInsertIndex=$finalTargetInsertIndex, isMovingSameList=$isMovingSameList, item=${itemToMove.hashCode}",
    );

    if (isMovingSameList) {
      setState(() {
        if (originalIndex != -1) {
          final StoryConvertible itemRemoved = widget.storyConvertible.removeAt(
            originalIndex,
          );
          // 조정된 최종 타겟 인덱스 사용
          int insertionPoint = finalTargetInsertIndex.clamp(
            0,
            widget.storyConvertible.length,
          );

          // ignore: avoid_print
          print(
            "ChildrenBlockState.onDrag (same list insert): originalIndex=$originalIndex, targetFromDivider=$targetInsertIndexFromDivider, FINAL insertionPoint=$insertionPoint, item hash=${itemRemoved.hashCode}",
          );
          widget.storyConvertible.insert(insertionPoint, itemRemoved);
        }
      });
    } else {
      // 다른 리스트에서 오는 경우, Divider에서 온 targetInsertIndexFromDivider를 직접 사용
      draggableData.removeFromSourceCallback(itemToMove);
      setState(() {
        // ignore: avoid_print
        print(
          "ChildrenBlockState.onDrag (different list insert): targetFromDivider=$targetInsertIndexFromDivider, item hash=${itemToMove.hashCode}",
        );
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
      // ignore: avoid_print
      print("ChildrenBlockState.removeItem: removing item ${model.hashCode}");
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlockDivider(
                    onPressed: () {},
                    onDrag: (details) {
                      // ignore: avoid_print
                      print(
                        "TOP BlockDivider targeted, passing targetInsertIndex: 0, item hash=${details.data.item.hashCode}",
                      );
                      onDrag(details.data, 0);
                    },
                  ),
                  ...widget.storyConvertible.indexed.expand((entry) {
                    int itemIndex = entry.$1;
                    StoryConvertible currentItem = entry.$2;
                    return [
                      IntentBlock(
                        key: ObjectKey(currentItem),
                        storyConvertible: currentItem,
                        project: widget.project,
                        removeItemCallback: removeItem,
                        currentList: widget.storyConvertible,
                      ),
                      BlockDivider(
                        onPressed: () {},
                        onDrag: (details) {
                          // ignore: avoid_print
                          print(
                            "INTER-ITEM BlockDivider (after item at $itemIndex, ${currentItem.hashCode}) targeted, passing targetInsertIndex: ${itemIndex + 1}, item hash=${details.data.item.hashCode}",
                          );
                          onDrag(details.data, itemIndex + 1);
                        },
                      ),
                    ];
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
