import 'package:flutter/material.dart';

import '../../core/execute_model.dart';
import '../../core/story_convertible.dart';
import '../common/block_row.dart';
import '../common/block_textfield.dart';

class ExecuteBlock extends StatefulWidget {
  final ExecuteModel executeModel;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const ExecuteBlock({
    super.key,
    required this.executeModel,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  ExecuteBlockState createState() => ExecuteBlockState();
}

class ExecuteBlockState extends State<ExecuteBlock> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: widget.executeModel.executionId,
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlockRow(
      title: '실행',
      model: widget.executeModel,
      removeItemCallback: widget.removeItemCallback,
      currentList: widget.currentList,
      children: [
        Expanded(child: BlockTextField(controller: _contentController)),
      ],
    );
  }
}
