import 'package:flutter/material.dart';

import '../../core/base_model.dart';
import '../../story_dart/project.dart';

class BaseBlock extends StatelessWidget {
  final BaseModel baseModel;
  final Project project;

  const BaseBlock({super.key, required this.baseModel, required this.project});

  @override
  Widget build(BuildContext context) {
    return Text(baseModel.baseId);
  }
}
