import 'package:flutter/material.dart';

import '../../../core/background_model.dart';
import 'package:story_dart/project.dart';
import '../common/block_dropdown.dart';
import '../common/block_row.dart';
import 'children_block.dart';
import '../../core/story_convertible.dart';

class BackgroundBlock extends StatefulWidget {
  final BackgroundModel backgroundModel;
  final Project project;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const BackgroundBlock({
    super.key,
    required this.backgroundModel,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  State<BackgroundBlock> createState() => _BackgroundBlockState();
}

class _BackgroundBlockState extends State<BackgroundBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlockRow(
          title: '배경',
          model: widget.backgroundModel,
          removeItemCallback: widget.removeItemCallback,
          currentList: widget.currentList,
          children: [
            SizedBox(
              width: 200,
              child: BlockDropdown<String>(
                value: widget.backgroundModel.backgroundId,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      widget.backgroundModel.backgroundId = value;
                    });
                  }
                },
                items:
                    widget.project.backgrounds
                        .map(
                          (it) => DropdownMenuItem(
                            value: it.id,
                            child: Text(it.name),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
        ChildrenBlock(
          storyConvertible: widget.backgroundModel.children,
          project: widget.project,
        ),
      ],
    );
  }
}
