import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:storymaker/settings/settings_view.dart';
import 'package:window_manager/window_manager.dart';
import 'story_dart/parser.dart';
import 'story_dart/project.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainState();
}

class MainState extends State<MainView> {
  String? _currentStoryId;
  String? _currentProjectPath;
  Project? currentProject;

  Future<void> pickProject() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Project XML 파일을 선택해주세요.',
      type: FileType.custom,
      allowedExtensions: ['xml'],
    );
    if (result != null) {
      try {
        String? path = result.files.single.path;
        File file = File(path!);
        String string = await file.readAsString();
        XMLNode node = XMLNode.fromXMLString(string);
        Project project = Project.fromXMLNode(node);
        windowManager.setTitle('${project.name} - StoryMaker');
        setState(() {
          _currentProjectPath = path;
          currentProject = project;
        });
      } catch (e) {
        await FlutterPlatformAlert.playAlertSound();
        await FlutterPlatformAlert.showAlert(
          windowTitle: '오류',
          text: '유효한 Project XML 파일이 아닙니다.',
          alertStyle: AlertButtonStyle.ok,
          iconStyle: IconStyle.information,
        );
      }
    }
  }

  void selectSettings() {
    setState(() {
      _currentStoryId = null;
    });
  }

  void selectStory(String id) {
    setState(() {
      _currentStoryId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (currentProject != null)
            ? Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.edit_document, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    currentProject!.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '프로젝트 설정',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          minTileHeight: 50,
                          onTap: () => selectSettings(),
                          selected: _currentStoryId == null,
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: ListView(
                            children: [
                              ...currentProject!.stories.map(
                                (it) => ListTile(
                                  title: Text(
                                    it.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  minTileHeight: 5,
                                  onTap: () => selectStory(it.id),
                                  selected: _currentStoryId == it.id,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: (_currentStoryId == null)
                        ? const SettingsView()
                        : const Text(''),
                  ),
                ],
              )
            : TextButton(
                onPressed: pickProject,
                child: const Text('Pick'),
              ),
      ),
    );
  }
}
