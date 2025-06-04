import 'story_convertible.dart';

class DraggableItemData {
  final StoryConvertible item;
  final Function(StoryConvertible) removeFromSourceCallback;
  final List<StoryConvertible> sourceList;

  DraggableItemData({
    required this.item,
    required this.removeFromSourceCallback,
    required this.sourceList,
  });
}
