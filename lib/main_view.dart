import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:storymaker/children/story/story_list_view.dart';
import 'package:window_manager/window_manager.dart';
import 'story_dart/parser.dart';
import 'story_dart/project.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainState();
}

class MainState extends State<MainView> {
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

  void closeProject() {
    setState(() {
      _currentProjectPath = null;
      currentProject = null;
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuBar(
            style: MenuStyle(elevation: WidgetStateProperty.all(0)),
            children: [
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {
                      showAboutDialog(context: context);
                    },
                    child: const Text('StoryMaker에 대하여'),
                  ),
                ],
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'StoryMaker',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {},
                    child: const Text('새 프로젝트 만들기'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      pickProject();
                    },
                    child: const Text('프로젝트 열기'),
                  ),
                  MenuItemButton(
                    onPressed: () {},
                    child: const Text('프로젝트 전체 저장'),
                  ),
                  MenuItemButton(
                    onPressed: closeProject,
                    child: const Text('프로젝트 닫기'),
                  ),
                ],
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Center(child: Text('파일')),
                ),
              ),
            ],
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: Center(
              child:
                  (currentProject != null)
                      ? Row(
                        children: [
                          NavigationRail(
                            labelType: NavigationRailLabelType.all,
                            destinations: const [
                              NavigationRailDestination(
                                icon: Icon(Icons.auto_stories_outlined),
                                selectedIcon: Icon(Icons.auto_stories),
                                label: Text('스토리'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.people_outlined),
                                selectedIcon: Icon(Icons.people),
                                label: Text('캐릭터'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.image_outlined),
                                selectedIcon: Icon(Icons.image),
                                label: Text('배경'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.smart_display_outlined),
                                selectedIcon: Icon(Icons.smart_display),
                                label: Text('컷씬'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.music_note_outlined),
                                selectedIcon: Icon(Icons.music_note),
                                label: Text('사운드'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.keyboard_command_key_outlined),
                                selectedIcon: Icon(Icons.keyboard_command_key),
                                label: Text('변수'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.settings_outlined),
                                selectedIcon: Icon(Icons.settings),
                                label: Text('설정'),
                              ),
                            ],
                            selectedIndex: selectedIndex,
                            onDestinationSelected: (index) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                          const VerticalDivider(thickness: 1, width: 1),
                          StoryListView(project: currentProject),
                          const VerticalDivider(thickness: 1, width: 1),
                        ],
                      )
                      : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 30,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'StoryMaker',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '시작하려면 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextButton(
                                      onPressed: pickProject,
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      child: const Text(
                                        '프로젝트를 선택',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '해주세요.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              child: Image.asset('assets/image/mary.webp'),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
