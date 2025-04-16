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
          highlightColor: Colors.pink.shade50,
          splashFactory: NoSplash.splashFactory,
          tabBarTheme: TabBarTheme(
            dividerColor: Colors.black12,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.pink.shade50;
                } else if (states.contains(WidgetState.hovered)) {
                  return Colors.grey.shade100;
                } else {
                  return null;
                }
              },
            ),
          ),
          dividerTheme: const DividerThemeData(
            color: Colors.black12,
          ),
        ),
        home: const MainView(),
      ),
    );
  }
}
