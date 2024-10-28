import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:storymaker/settings_view.dart';
import 'package:storymaker/story_list_cell.dart';
import 'package:window_manager/window_manager.dart';
import 'package:story_dart/parser.dart';
import 'package:story_dart/project.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String? _currentProjectPath;
  Project? _currentProject;

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
          _currentProject = project;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_currentProject != null)
            ? Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ..._currentProject!.stories.map((it) =>
                          StoryListCell(name: it.name, isSelected: false)),
                    ],
                  ),
                  const Expanded(
                    child: SettingsView(),
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
