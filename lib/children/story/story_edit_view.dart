import 'package:flutter/material.dart';
import 'package:storymaker/core/story_convertible.dart';
import '../../story_dart/story.dart';

class StoryEditView extends StatefulWidget {
  final Story story;

  const StoryEditView({super.key, required this.story});

  @override
  State<StoryEditView> createState() => StoryEditState();
}

class StoryEditState extends State<StoryEditView> {

  void storyToIntents() {
    print(fromStory(widget.story).toString());
  }

  @override
  Widget build(BuildContext context) {
    storyToIntents();
    return Row(
      children: [
        Text(widget.story.toXMLNode().toXMLString())
      ],
    );
  }
}
