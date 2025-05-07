import '../story_dart/story.dart';
import 'audio_model.dart';
import 'background_model.dart';
import 'base_model.dart';
import 'character_model.dart';
import 'choices_model.dart';
import 'delay_model.dart';
import 'dialog_model.dart';
import 'execute_model.dart';
import 'monolog_model.dart';
import 'overlay_model.dart';
import 'scene_model.dart';

abstract interface class StoryConvertible {}

extension StoryExtension on Story {
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
            fromIntents(
              intent.body,
              characterId: characterId,
              sceneId: sceneId,
            ),
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
        return [
          CharacterModel(intent.id, intent.base, intent.overlay, intent.show),
          if (intent.body != null)
            ...fromIntents(
              intent.body!,
              characterId: intent.id,
              sceneId: sceneId,
            ),
        ];

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
            return [
              DialogModel(
                body.body,
                intent.name,
                intent.name == null ? characterId : null,
              ),
            ];
          case DialogChoices():
            return [
              ChoicesModel(
                Map.fromEntries(
                  body.body.map(
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

  List<StoryConvertible> toStoryConvertible() => fromIntents(body);
}
