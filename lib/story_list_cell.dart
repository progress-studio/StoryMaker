import 'package:flutter/widgets.dart';

class StoryListCell extends StatelessWidget {
  const StoryListCell({
    super.key,
    required this.name,
    required this.isSelected,
  });

  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text(name)]);
  }
}
