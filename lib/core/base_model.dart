import 'story_convertible.dart';

class BaseModel implements StoryConvertible {
  String baseId;
  String? characterId;
  String? sceneId;

  BaseModel(this.baseId, this.characterId, this.sceneId);
}
