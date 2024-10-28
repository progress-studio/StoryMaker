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
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
          useMaterial3: true,
          highlightColor: Colors.pink.shade50,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const MainView(),
      ),
    );
  }
}
