import 'package:flutter/material.dart';

import '../core/overlay_model.dart';
import '../story_dart/project.dart';

class OverlayBlock extends StatelessWidget {
  final OverlayModel overlayModel;
  final Project project;

  const OverlayBlock({
    super.key,
    required this.overlayModel,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Text(overlayModel.overlayId);
  }
}
