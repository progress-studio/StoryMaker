import 'story_convertible.dart';

class OverlayModel implements StoryConvertible {
  String overlayId;
  String? characterId;
  String? sceneId;

  OverlayModel(this.overlayId, this.characterId, this.sceneId);
}
