import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../main_view.dart';
import '../story_dart/project.dart';

class ProjectSettingsView extends StatefulWidget {
  const ProjectSettingsView({super.key, required this.mainState});

  final MainState mainState;

  @override
  State<ProjectSettingsView> createState() => _ProjectSettingsState();
}

class _ProjectSettingsState extends State<ProjectSettingsView> {
  late Project project = widget.mainState.currentProject!;
  late final TextEditingController _titleController =
      TextEditingController(text: project.name);

  void updateTitle(String to) {
    widget.mainState.setState(() {
      project.name = to;
    });
    windowManager.setTitle('$to - StoryMaker');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              labelText: '게임 제목',
            ),
            onChanged: (it) => updateTitle(it),
          ),
        ],
      ),
    );
  }
}
