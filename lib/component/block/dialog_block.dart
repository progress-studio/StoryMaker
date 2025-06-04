import 'package:flutter/material.dart';

import '../../core/dialog_model.dart';
import 'package:story_dart/project.dart';
import '../common/block_dropdown.dart';
import '../common/block_row.dart';
import '../common/block_textfield.dart';
import '../../core/story_convertible.dart';

class DialogBlock extends StatefulWidget {
  final DialogModel dialogModel;
  final Project project;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const DialogBlock({
    super.key,
    required this.dialogModel,
    required this.project,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  DialogBlockState createState() => DialogBlockState();
}

class DialogBlockState extends State<DialogBlock> {
  late TextEditingController _contentController;
  late TextEditingController _customNameController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.dialogModel.body);
    _customNameController = TextEditingController(
      text: widget.dialogModel.name,
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _customNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlockRow(
      title: '대사',
      model: widget.dialogModel,
      removeItemCallback: widget.removeItemCallback,
      currentList: widget.currentList,
      children: [
        SizedBox(
          width: 150,
          child: BlockDropdown<String?>(
            value: widget.dialogModel.characterId,
            onChanged: (String? value) {
              setState(() {
                widget.dialogModel.characterId = value;
                if (value != null) {
                  widget.dialogModel.name = null;
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('이름을 입력하세요.'),
                        content: TextField(controller: _customNameController),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                widget.dialogModel.name =
                                    _customNameController.text;
                              });
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            items: [
              ...widget.project.characters.map(
                (it) => DropdownMenuItem(value: it.id, child: Text(it.name)),
              ),
              DropdownMenuItem(
                value: null,
                child: Text(widget.dialogModel.name ?? '사용자 지정'),
              ),
            ],
          ),
        ),
        Expanded(child: BlockTextField(controller: _contentController)),
      ],
    );
  }
}
