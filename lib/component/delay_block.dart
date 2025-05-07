import 'package:flutter/material.dart';

import '../core/delay_model.dart';
import 'block_row.dart';
import 'block_textfield.dart';

class DelayBlock extends StatefulWidget {
  final DelayModel delayModel;

  const DelayBlock({super.key, required this.delayModel});

  @override
  DelayBlockState createState() => DelayBlockState();
}

class DelayBlockState extends State<DelayBlock> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.delayModel.duration.toString());
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
      children: [
        Expanded(child: BlockTextField(controller: _contentController)),
      ],
    );
  }
}