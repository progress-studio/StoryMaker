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
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const IntentBlock({
    super.key,
    required this.storyConvertible,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  Widget build(BuildContext context) {
    switch (storyConvertible) {
      case AudioModel audioModel:
        return AudioBlock(
          audioModel: audioModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case BackgroundModel backgroundModel:
        return BackgroundBlock(
          backgroundModel: backgroundModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case BaseModel baseModel:
        return BaseBlock(baseModel: baseModel, project: project);
      case CharacterModel characterModel:
        return CharacterBlock(
          characterModel: characterModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case ChoicesModel choicesModel:
        return ChoicesBlock(choicesModel: choicesModel);
      case DelayModel delayModel:
        return DelayBlock(
          delayModel: delayModel,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case DialogModel dialogModel:
        return DialogBlock(
          dialogModel: dialogModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case ExecuteModel executeModel:
        return ExecuteBlock(executeModel: executeModel);
      case MonologModel monologModel:
        return MonologBlock(
          monologModel: monologModel,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case OverlayModel overlayModel:
        return OverlayBlock(
          overlayModel: overlayModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      case SceneModel sceneModel:
        return SceneBlock(
          sceneModel: sceneModel,
          project: project,
          removeItemCallback: removeItemCallback,
          currentList: currentList,
        );
      default:
        throw UnimplementedError(
          'Unhandled storyConvertible type: ${storyConvertible.runtimeType}',
        );
    }
  }
}
