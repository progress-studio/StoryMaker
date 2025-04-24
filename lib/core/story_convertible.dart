import 'package:storymaker/core/choices_model.dart';
import 'package:storymaker/core/dialog_model.dart';
import 'package:storymaker/core/execute_model.dart';
import 'package:storymaker/core/scene_model.dart';

import '../story_dart/story.dart';
import 'audio_model.dart';
import 'background_model.dart';
import 'base_model.dart';
import 'character_model.dart';
import 'delay_model.dart';
import 'monolog_model.dart';
import 'overlay_model.dart';

abstract interface class StoryConvertible {}

List<StoryConvertible> fromIntents(
  List<Intent> intents, {
  String? characterId,
  String? sceneId,
}) =>
    intents
        .expand(
          (intent) =>
              fromIntent(intent, characterId: characterId, sceneId: sceneId),
        )
        .toList();

List<StoryConvertible> fromIntent(
  Intent intent, {
  String? characterId,
  String? sceneId,
}) {
  switch (intent) {
    case Story():
      return [];

    case Audio():
      return [
        AudioModel(
          intent.id,
          (intent.body == null)
              ? null
              : fromIntents(
                intent.body!,
                characterId: characterId,
                sceneId: sceneId,
              ),
        ),
      ];

    case Background():
      return [
        BackgroundModel(
          intent.id,
          fromIntents(intent.body, characterId: characterId, sceneId: sceneId),
        ),
      ];

    case Scene():
      return [
        SceneModel(
          intent.id,
          intent.base,
          intent.overlay,
          fromIntents(
            intent.body,
            characterId: characterId,
            sceneId: intent.id,
          ),
        ),
      ];

    case Character():
      if (intent.body == null) {
        return [CharacterModel(intent.id, intent.show)];
      } else {
        return fromIntents(
          intent.body!,
          characterId: intent.id,
          sceneId: sceneId,
        );
      }

    case Base():
      return [
        BaseModel(intent.id, (sceneId == null) ? characterId : null, sceneId),
      ];

    case Overlay():
      return [
        OverlayModel(
          intent.id,
          (sceneId == null) ? characterId : null,
          sceneId,
        ),
      ];

    case Dialog():
      DialogBody body = intent.body;
      switch (body) {
        case DialogText():
          return [DialogModel(body.body, intent.name, characterId)];
        case DialogChoices():
          return [
            ChoicesModel(
              Map.fromEntries(
                (body.body as DialogChoices).body.map(
                  (it) => MapEntry(
                    it.text,
                    fromIntents(
                      it.body,
                      characterId: characterId,
                      sceneId: sceneId,
                    ),
                  ),
                ),
              ),
            ),
          ];
      }

    case Monolog():
      return [MonologModel(intent.body)];

    case Variable():
      // TODO
      return [];

    case Execute():
      return [ExecuteModel(intent.id)];

    case Delay():
      return [DelayModel(intent.duration)];
  }
}

List<StoryConvertible> fromStory(Story story) => fromIntents(story.body);
