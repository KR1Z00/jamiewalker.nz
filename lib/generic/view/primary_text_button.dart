import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    final textTheme = context.textTheme();

    final textStyle =
        getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.desktop
            ? textTheme.labelLarge
            : textTheme.labelMedium;

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
