import 'story_convertible.dart';

class SceneModel implements StoryConvertible {
  String sceneId;
  String? baseId;
  String? overlayId;
  final List<StoryConvertible> children;

  SceneModel(this.sceneId, this.baseId, this.overlayId, this.children);
}
