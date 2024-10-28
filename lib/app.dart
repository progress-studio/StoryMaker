import 'package:flutter/material.dart';
import 'main_view.dart';

class StoryMakerApp extends StatelessWidget {
  const StoryMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [],
      child: MaterialApp(
        title: 'StoryMaker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainView(),
      ),
    );
  }
}
