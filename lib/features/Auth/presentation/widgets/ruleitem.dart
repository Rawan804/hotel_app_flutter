import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/theme/app_theme.dart';

class RuleItem extends StatelessWidget {
  final String text;
  final bool value;

  const RuleItem({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.circle_outlined,
          color: value ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(text,style:  Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
      ],
    );
  }
}