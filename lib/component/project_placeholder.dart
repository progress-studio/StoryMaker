import 'package:flutter/material.dart';

class ProjectPlaceholder extends StatelessWidget {
  final Function() action;
  const ProjectPlaceholder({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30,
        children: [
          Column(
            children: [
              const Text(
                'StoryMaker',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '시작하려면 ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: action,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      '프로젝트를 선택',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    '해주세요.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 200,
            child: Image.asset('assets/image/mary.webp'),
          ),
        ],
      ),
    );
  }
}