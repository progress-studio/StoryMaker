import 'story_convertible.dart';

class CharacterModel implements StoryConvertible {
  String characterId;
  String? baseId;
  String? overlayId;
  bool? show;

  CharacterModel(this.characterId, this.baseId, this.overlayId, this.show);
}
