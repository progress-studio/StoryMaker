import 'package:flutter/material.dart';
import '../component/block/intent_block.dart';
import '../core/story_convertible.dart';
import 'package:story_dart/project.dart';

class StoryEditView extends StatefulWidget {
  final List<StoryConvertible> storyConvertible;
  final Project project;

  const StoryEditView({
    super.key,
    required this.storyConvertible,
    required this.project,
  });

  @override
  State<StoryEditView> createState() => StoryEditState();
}

class StoryEditState extends State<StoryEditView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        widget.storyConvertible
                            .map(
                              (it) => IntentBlock(
                                storyConvertible: it,
                                project: widget.project,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
