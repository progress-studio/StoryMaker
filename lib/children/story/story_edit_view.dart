import 'package:flutter/material.dart';
import '../../story_dart/story.dart';

class StoryEditView extends StatefulWidget {
  final Story story;

  const StoryEditView({super.key, required this.story});

  @override
  State<StoryEditView> createState() => StoryEditState();
}

class StoryEditState extends State<StoryEditView> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.story.toXMLNode().toXMLString())
      ],
    );
  }
}
