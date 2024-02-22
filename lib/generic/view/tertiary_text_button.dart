import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TertiaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const TertiaryTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();

    final textStyle =
        getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.desktop
            ? textTheme.labelLarge
            : textTheme.labelMedium;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.all(
          context.colorScheme().secondary,
        ),
      ),
      child: Text(
        title,
        style: textStyle?.copyWith(
          color: context.colorScheme().secondary,
        ),
      ),
    );
  }
}
