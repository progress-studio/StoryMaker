import 'package:flutter/material.dart';

import '../core/execute_model.dart';

class ExecuteBlock extends StatelessWidget {
  final ExecuteModel executeModel;

  const ExecuteBlock({super.key, required this.executeModel});

  @override
  Widget build(BuildContext context) {
    return Text(executeModel.executionId);
  }
}
