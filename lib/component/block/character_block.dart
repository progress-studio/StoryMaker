import 'package:flutter/material.dart';

import '../../core/character_model.dart';
import '../../story_dart/project.dart';

class CharacterBlock extends StatelessWidget {
  final CharacterModel characterModel;
  final Project project;

  const CharacterBlock({
    super.key,
    required this.characterModel,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Text(characterModel.characterId);
  }
}
