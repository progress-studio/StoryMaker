import 'package:flutter/material.dart';

import '../../core/scene_model.dart';
import '../../story_dart/project.dart';
import '../common/block_dropdown.dart';
import '../common/block_row.dart';
import 'children_block.dart';

class SceneBlock extends StatefulWidget {
  final SceneModel sceneModel;
  final Project project;

  const SceneBlock({
    super.key,
    required this.sceneModel,
    required this.project,
  });

  @override
  State<SceneBlock> createState() => _SceneBlockState();
}

class _SceneBlockState extends State<SceneBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlockRow(
          title: '컷씬',
          children: [
            SizedBox(
              width: 200,
              child: BlockDropdown<String>(
                value: widget.sceneModel.sceneId,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      widget.sceneModel.sceneId = value;
                    });
                  }
                },
                items:
                    widget.project.scenes
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
          storyConvertible: widget.sceneModel.children,
          project: widget.project,
        ),
      ],
    );
  }
}
