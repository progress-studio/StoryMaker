import 'package:flutter/material.dart';

import '../core/scene_model.dart';
import '../story_dart/project.dart';
import 'children_block.dart';

class SceneBlock extends StatelessWidget {
  final SceneModel sceneModel;
  final Project project;

  const SceneBlock({
    super.key,
    required this.sceneModel,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sceneModel.sceneId),
        ChildrenBlock(storyConvertible: sceneModel.children, project: project),
      ],
    );
  }
}
