import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';

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
    final layoutForMobile = context.layoutForMobile();
    final textTheme = context.textTheme();

    final textStyle =
        layoutForMobile ? textTheme.labelMedium : textTheme.labelLarge;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            context.colorScheme().secondary,
          ),
          foregroundColor: MaterialStateProperty.all(
            context.colorScheme().onSecondary,
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.5),
          ),
          textStyle: MaterialStateProperty.all(textStyle),
        ),
        child: Text(title),
      ),
    );
  }
}
