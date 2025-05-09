import 'package:flutter/material.dart';

import '../../core/monolog_model.dart';
import '../common/block_row.dart';
import '../common/block_textfield.dart';

class MonologBlock extends StatefulWidget {
  final MonologModel monologModel;

  const MonologBlock({super.key, required this.monologModel});

  @override
  MonologBlockState createState() => MonologBlockState();
}

class MonologBlockState extends State<MonologBlock> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.monologModel.body);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlockRow(
      title: '독백',
      children: [
        Expanded(child: BlockTextField(controller: _contentController)),
      ],
    );
  }
}
