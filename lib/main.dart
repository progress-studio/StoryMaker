import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'feature/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setTitle('StoryMaker');
  runApp(const StoryMakerApp());
}

