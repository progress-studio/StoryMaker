import 'package:flutter/material.dart';

import '../../core/audio_model.dart';
import 'package:story_dart/project.dart';
import '../common/block_row.dart';
import 'children_block.dart';
import '../common/block_dropdown.dart';
import '../../core/story_convertible.dart';

class AudioBlock extends StatefulWidget {
  final AudioModel audioModel;
  final Project project;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const AudioBlock({
    super.key,
    required this.audioModel,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  State<AudioBlock> createState() => _AudioBlockState();
}

class _AudioBlockState extends State<AudioBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlockRow(
          title: '사운드',
          model: widget.audioModel,
          removeItemCallback: widget.removeItemCallback,
          currentList: widget.currentList,
          children: [
            SizedBox(
              width: 200,
              child: BlockDropdown<String>(
                value: widget.audioModel.audioId,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      widget.audioModel.audioId = value;
                    });
                  }
                },
                items:
                    widget.project.sounds
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
        if (widget.audioModel.children != null)
          ChildrenBlock(
            storyConvertible: widget.audioModel.children!,
            project: widget.project,
          ),
      ],
    );
  }
}
