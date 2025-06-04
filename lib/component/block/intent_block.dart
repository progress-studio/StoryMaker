import 'package:flutter/material.dart';
import 'package:story_dart/project.dart';
import 'scene_block.dart';

import '../../core/audio_model.dart';
import '../../core/background_model.dart';
import '../../core/base_model.dart';
import '../../core/character_model.dart';
import '../../core/choices_model.dart';
import '../../core/delay_model.dart';
import '../../core/dialog_model.dart';
import '../../core/execute_model.dart';
import '../../core/monolog_model.dart';
import '../../core/overlay_model.dart';
import '../../core/scene_model.dart';
import '../../core/story_convertible.dart';
import 'audio_block.dart';
import 'background_block.dart';
import 'base_block.dart';
import 'character_block.dart';
import 'choices_block.dart';
import 'delay_block.dart';
import 'dialog_block.dart';
import 'execute_block.dart';
import 'monolog_block.dart';
import 'overlay_block.dart';

class IntentBlock extends StatelessWidget {
  final StoryConvertible storyConvertible;
  final Project project;

  const IntentBlock({
    super.key,
    required this.storyConvertible,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    switch (storyConvertible) {
      case AudioModel audioModel:
        return AudioBlock(audioModel: audioModel, project: project);
      case BackgroundModel backgroundModel:
        return BackgroundBlock(backgroundModel: backgroundModel, project: project);
      case BaseModel baseModel:
        return BaseBlock(baseModel: baseModel, project: project);
      case CharacterModel characterModel:
        return CharacterBlock(characterModel: characterModel, project: project);
      case ChoicesModel choicesModel:
        return ChoicesBlock(choicesModel: choicesModel);
      case DelayModel delayModel:
        return DelayBlock(delayModel: delayModel);
      case DialogModel dialogModel:
        return DialogBlock(dialogModel: dialogModel, project: project);
      case ExecuteModel executeModel:
        return ExecuteBlock(executeModel: executeModel);
      case MonologModel monologModel:
        return MonologBlock(monologModel: monologModel);
      case OverlayModel overlayModel:
        return OverlayBlock(overlayModel: overlayModel, project: project);
      case SceneModel sceneModel:
        return SceneBlock(sceneModel: sceneModel, project: project);
      default:
        throw UnimplementedError(
          'Unhandled storyConvertible type: ${storyConvertible.runtimeType}',
        );
    }
  }
}
