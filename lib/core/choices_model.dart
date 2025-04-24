import 'story_convertible.dart';

class ChoicesModel implements StoryConvertible {
  final Map<String, List<StoryConvertible>> choices;

  ChoicesModel(this.choices);
}
