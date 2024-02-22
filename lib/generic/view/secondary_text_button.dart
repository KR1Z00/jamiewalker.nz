import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SecondaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const SecondaryTextButton({
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
            context.colorScheme().background,
          ),
          foregroundColor: MaterialStateProperty.all(
            context.colorScheme().secondary,
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
          side: MaterialStateProperty.all(
            BorderSide(
              color: context.colorScheme().secondary,
            ),
          ),
          overlayColor: MaterialStateProperty.all(
            context.colorScheme().secondary.withOpacity(0.5),
          ),
          textStyle: MaterialStateProperty.all(
            textStyle?.copyWith(
              color: context.colorScheme().onBackground,
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
