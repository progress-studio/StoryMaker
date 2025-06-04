import 'package:flutter/material.dart';

import '../../core/story_convertible.dart';
import '../../story_dart/project.dart';
import '../common/block_divider.dart';
import 'intent_block.dart';

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
  void onDrag(StoryConvertible model, int index) {
    setState(() {
      widget.storyConvertible.insert(index, model);
    });
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
                    children: [
                      ...widget.storyConvertible.indexed.map(
                        (entry) => Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            IntentBlock(
                              storyConvertible: entry.$2,
                              project: widget.project,
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
                      ),
                    ],
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
