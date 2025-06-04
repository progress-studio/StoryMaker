import 'package:flutter/material.dart';

import '../../core/character_model.dart';
import 'package:story_dart/project.dart';
import '../common/block_dropdown.dart';
import '../common/block_row.dart';
import '../../core/story_convertible.dart';

class CharacterBlock extends StatefulWidget {
  final CharacterModel characterModel;
  final Project project;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const CharacterBlock({
    super.key,
    required this.characterModel,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  CharacterBlockState createState() => CharacterBlockState();
}

class CharacterBlockState extends State<CharacterBlock> {
  @override
  Widget build(BuildContext context) {
    return BlockRow(
      title: '캐릭터',
      model: widget.characterModel,
      removeItemCallback: widget.removeItemCallback,
      currentList: widget.currentList,
      children: [
        SizedBox(
          width: 150,
          child: BlockDropdown<String>(
            value: widget.characterModel.characterId,
            onChanged: (String? value) {
              setState(() {
                widget.characterModel.characterId = value!;
              });
            },
            items:
                widget.project.characters
                    .map(
                      (it) =>
                          DropdownMenuItem(value: it.id, child: Text(it.name)),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
