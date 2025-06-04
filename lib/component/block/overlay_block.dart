import 'package:flutter/material.dart';

import '../../core/overlay_model.dart';
import 'package:story_dart/project.dart';
import '../../core/story_convertible.dart';
import '../common/block_row.dart';

class OverlayBlock extends StatelessWidget {
  final OverlayModel overlayModel;
  final Project project;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const OverlayBlock({
    super.key,
    required this.overlayModel,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  Widget build(BuildContext context) {
    return BlockRow(
      title: '오버레이',
      model: overlayModel,
      removeItemCallback: removeItemCallback,
      currentList: currentList,
    );
  }
}
