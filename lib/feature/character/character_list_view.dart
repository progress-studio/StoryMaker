import 'package:flutter/material.dart';
import 'package:story_dart/project.dart';

class CharacterListView extends StatefulWidget {
  final Project project;

  const CharacterListView({super.key, required this.project});

  @override
  State<CharacterListView> createState() => CharacterListState();
}

class CharacterListState extends State<CharacterListView> {
  String? currentCharacterId;

  void selectCharacter(String id) {
    setState(() {
      if (currentCharacterId == null || currentCharacterId != id) {
        currentCharacterId = id;
      } else {
        currentCharacterId = null;
      }
    });
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final character = widget.project.stories.removeAt(oldIndex);
      widget.project.stories.insert(newIndex, character);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Text('캐릭터', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Expanded(
                child: ReorderableListView(
                  onReorder: onReorder,
                  buildDefaultDragHandles: false,
                  padding: const EdgeInsets.only(top: 0),
                  children: [
                    for (final character in widget.project.characters)
                      ReorderableDragStartListener(
                        key: ValueKey(character.id),
                        index: widget.project.characters.indexOf(character),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          title: Text(
                            character.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          selected: currentCharacterId == character.id,
                          selectedTileColor: Colors.blue.shade50,
                          onTap: () => selectCharacter(character.id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // if (currentCharacterId != null)
        //   CharacterEditView(
        //     characterId: currentCharacterId!,
        //     project: widget.project,
        //   ),
      ],
    );
  }
}
