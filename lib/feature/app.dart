import 'package:flutter/material.dart';
import 'main_view.dart';

class StoryMakerApp extends StatelessWidget {
  const StoryMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoryMaker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        highlightColor: Colors.blue.shade50,
        splashFactory: NoSplash.splashFactory,
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.black12,
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.blue.shade50;
            } else if (states.contains(WidgetState.hovered)) {
              return Colors.grey.shade100;
            } else {
              return null;
            }
          }),
        ),
        dividerTheme: const DividerThemeData(color: Colors.black12),
      ),
      home: const MainView(),
    );
  }
}
