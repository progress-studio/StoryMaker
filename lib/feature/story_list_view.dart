import 'dart:io';
import 'package:flutter/material.dart';
import 'story_edit_view.dart';
import '../core/story_convertible.dart';
import 'package:story_dart/parser.dart';
import 'package:story_dart/project.dart';
import 'package:story_dart/story.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:path/path.dart' as p;

class StoryListView extends StatefulWidget {
  final Project project;
  final String projectPath;

  const StoryListView({
    super.key,
    required this.project,
    required this.projectPath,
  });

  @override
  State<StoryListView> createState() => StoryListState();
}

class StoryListState extends State<StoryListView> {
  String? currentStoryId;
  List<StoryConvertible>? currentStoryConvertible;

  Future<void> loadStory(String id) async {
    try {
      String storySrc = widget.project.stories.getElement(id).src;
      String fullPath;
      if (p.isAbsolute(storySrc)) {
        fullPath = storySrc;
      } else {
        final projectDir = p.dirname(widget.projectPath);
        fullPath = p.join(projectDir, storySrc);
      }

      File file = File(fullPath);
      String string = await file.readAsString();
      XMLNode node = XMLNode.fromXMLString(string);
      Story story = Story.fromXMLNode(node);
      setState(() {
        currentStoryId = id;
        currentStoryConvertible = story.toStoryConvertible();
      });
    } catch (e) {
      await FlutterPlatformAlert.playAlertSound();
      await FlutterPlatformAlert.showAlert(
        windowTitle: '오류',
        text: '스토리 파일을 불러오는 중 오류가 발생했습니다: ${e.toString()}',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.error,
      );
    }
  }

  void selectStory(String id) {
    setState(() {
      if (currentStoryId == null) {
        loadStory(id);
      } else if (currentStoryId != id) {
        // TODO: SAVE TEMP
        loadStory(id);
      } else {
        currentStoryId = null;
        // TODO: SAVE TEMP
        currentStoryConvertible = null;
      }
    });
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final story = widget.project.stories.removeAt(oldIndex);
      widget.project.stories.insert(newIndex, story);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
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
                child: ReorderableListView(
                  onReorder: onReorder,
                  buildDefaultDragHandles: false,
                  padding: const EdgeInsets.only(top: 0),
                  children: [
                    for (final story in widget.project.stories)
                      ReorderableDragStartListener(
                        key: ValueKey(story.id),
                        index: widget.project.stories.indexOf(story),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          title: Text(
                            story.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          selected: currentStoryId == story.id,
                          selectedTileColor: Colors.blue.shade50,
                          onTap: () => selectStory(story.id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        if (currentStoryConvertible != null)
          StoryEditView(
            storyConvertible: currentStoryConvertible!,
            project: widget.project,
          ),
      ],
    );
  }
}
