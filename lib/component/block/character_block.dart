import 'package:flutter/material.dart';

import '../../core/character_model.dart';
import 'package:story_dart/project.dart';
import '../common/block_dropdown.dart';
import '../common/block_row.dart';

class CharacterBlock extends StatefulWidget {
  final CharacterModel characterModel;
  final Project project;

  const CharacterBlock({
    super.key,
    required this.characterModel,
    required this.project,
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
