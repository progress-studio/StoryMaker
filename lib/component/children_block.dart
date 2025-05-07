import 'package:flutter/material.dart';

import '../core/story_convertible.dart';
import '../story_dart/project.dart';
import 'intent_block.dart';

class ChildrenBlock extends StatelessWidget {
  final List<StoryConvertible> storyConvertible;
  final Project project;

  const ChildrenBlock({
    super.key,
    required this.storyConvertible,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Opacity(
            opacity: 0.2,
            child: VerticalDivider(color: Colors.black, thickness: 2),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DragTarget(
                //   builder: (context, candidateData, rejectedData) {
                //     final isHovered = candidateData.isNotEmpty;
                //     return Container(
                //       width: double.infinity,
                //       height: 3,
                //       color: isHovered ? Colors.blue : Colors.green,
                //     );
                //   },
                //   onAcceptWithDetails: (details) {
                //     print('드래그된 데이터: ${details.data}');
                //   },
                // ),
                ...storyConvertible.map(
                  (it) => IntentBlock(storyConvertible: it, project: project),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
