import 'package:flutter/material.dart';

import '../../core/delay_model.dart';
import '../common/block_row.dart';
import '../common/block_textfield.dart';
import '../../core/story_convertible.dart';

class DelayBlock extends StatefulWidget {
  final DelayModel delayModel;
  final Function(StoryConvertible) removeItemCallback;
  final List<StoryConvertible> currentList;

  const DelayBlock({
    super.key,
    required this.delayModel,
    required this.removeItemCallback,
    required this.currentList,
  });

  @override
  DelayBlockState createState() => DelayBlockState();
}

class DelayBlockState extends State<DelayBlock> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: widget.delayModel.duration.toString(),
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
      title: '지연',
      model: widget.delayModel,
      removeItemCallback: widget.removeItemCallback,
      currentList: widget.currentList,
      children: [
        Expanded(child: BlockTextField(controller: _contentController)),
      ],
    );
  }
}
