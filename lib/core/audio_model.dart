import 'story_convertible.dart';

class AudioModel implements StoryConvertible {
  String audioId;
  final List<StoryConvertible>? children;

  AudioModel(this.audioId, this.children);
}
