import 'story_convertible.dart';

class CharacterModel implements StoryConvertible {
  String characterId;
  bool? show;

  CharacterModel(this.characterId, this.show);
}
