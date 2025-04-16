import 'package:flutter/material.dart';
import '../../story_dart/project.dart';

class StoryListView extends StatefulWidget {
  final Project? project;

  const StoryListView({super.key, required this.project});

  @override
  State<StoryListView> createState() => StoryListState();
}

class StoryListState extends State<StoryListView> {
  String? currentStoryId;

  void selectStory(String id) {
    setState(() {
      currentStoryId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text('스토리', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView(
              children: widget.project!.stories.map((it) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: Text(
                    it.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                  minTileHeight: 5,
                  onTap: () => selectStory(it.id),
                  selected: currentStoryId == it.id,
                  selectedTileColor: Colors.blue.shade50,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
