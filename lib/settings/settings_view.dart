import 'package:flutter/material.dart';
import '../main_view.dart';
import 'project_settings_view.dart';

class SettingsViewTab extends StatelessWidget {
  const SettingsViewTab({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> with TickerProviderStateMixin {
  late MainState _mainState;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _mainState = context.findAncestorStateOfType<MainState>()!;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTab(IconData icon, String text) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: const [
          SettingsViewTab(icon: Icons.videogame_asset, text: '프로젝트'),
          SettingsViewTab(icon: Icons.people, text: '캐릭터'),
          SettingsViewTab(icon: Icons.image, text: '배경'),
          SettingsViewTab(icon: Icons.photo_camera_front, text: '스페셜 씬'),
          SettingsViewTab(icon: Icons.music_note, text: '사운드'),
          SettingsViewTab(icon: Icons.keyboard_command_key, text: '변수'),
        ]
      ),
      body: TabBarView(controller: _tabController, children: [
        Center(
          child: ProjectSettingsView(mainState: _mainState),
        ),
        const Center(
          child: Text('Character'),
        ),
        const Center(
          child: Text('BG'),
        ),
        const Center(
          child: Text('CG'),
        ),
        const Center(
          child: Text('Sound'),
        ),
        const Center(
          child: Text('Variable'),
        ),
      ]),
    );
  }
}
