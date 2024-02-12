import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';

class PrimaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const PrimaryTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: CustomButtonStyles.primaryActionButton(),
      child: Text(title),
    );
  }
}
