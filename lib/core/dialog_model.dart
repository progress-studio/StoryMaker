import 'story_convertible.dart';

class DialogModel implements StoryConvertible {
  String body;
  String? name;
  String? characterId;

  DialogModel(this.body, this.name, this.characterId);
}
