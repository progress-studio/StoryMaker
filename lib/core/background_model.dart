import 'story_convertible.dart';

class BackgroundModel implements StoryConvertible {
  String backgroundId;
  final List<StoryConvertible> children;

  BackgroundModel(this.backgroundId, this.children);
}
