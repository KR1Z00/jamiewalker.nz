import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';

class WelcomeSection extends StatelessWidget {
  final void Function() onContactMePressed;

  const WelcomeSection({
    super.key,
    required this.onContactMePressed,
  });

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: context.layoutForMobile()
          ? _WelcomeSectionMobile(
              onContactMePressed: onContactMePressed,
              onGithubPressed: _onGithubPressed,
              onLinkedInPressed: _onLinkedInPressed,
            )
          : _WelcomeSectionDesktop(
              onContactMePressed: onContactMePressed,
              onGithubPressed: _onGithubPressed,
              onLinkedInPressed: _onLinkedInPressed,
            ),
    );
  }

  void _onGithubPressed() {
    LaunchableUrls.github.launch();
  }

  void _onLinkedInPressed() {
    LaunchableUrls.linkedIn.launch();
  }
}

class _WelcomeSectionDesktop extends StatelessWidget {
  static const double minHeight = 700;
  static const double maxHeight = 1000;

  final void Function() onContactMePressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionDesktop({
    required this.onContactMePressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sectionHeight = max(min(screenHeight - 300, maxHeight), minHeight);

    return SizedBox(
      height: sectionHeight,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(LocaleKeys.fullName),
                    style: context.textTheme().displayLarge?.copyWith(
                          color: context.colorScheme().secondary,
                        ),
                  ),
                  Text(
                    tr(LocaleKeys.profession).toUpperCase(),
                    style: context.textTheme().displaySmall?.copyWith(
                          color: context.colorScheme().secondary,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      tr(LocaleKeys.introductionQuestion),
                      style: context.appTextStyles().bodyTextStyle(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      tr(LocaleKeys.introducion),
                      style: context.appTextStyles().bodyTextStyle(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PrimaryTextButton(
                            onPressed: onContactMePressed,
                            title: tr(LocaleKeys.contactMe),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: onLinkedInPressed,
                            icon: Image.asset(
                              'assets/images/linkedin.png',
                            ),
                            padding: EdgeInsets.zero,
                            style:
                                CustomButtonStyles.secondaryIconButton(context),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: onGithubPressed,
                            icon: Image.asset(
                              'assets/images/github.png',
                            ),
                            padding: EdgeInsets.zero,
                            style:
                                CustomButtonStyles.secondaryIconButton(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    StandardBoxShadows.regular(),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/profile_picture_square.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeSectionMobile extends StatelessWidget {
  static const double _maximumProfileImageWidth = 500;
  static const double _maximumProfileImageHeightRelativeToScreen = 0.4;

  final void Function() onContactMePressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionMobile({
    required this.onContactMePressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final profileImageWidth = min(
      _maximumProfileImageWidth,
      screenHeight * _maximumProfileImageHeightRelativeToScreen,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.minimumPadding.toDouble(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: profileImageWidth),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/profile_picture_square.jpg',
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenSize.minimumPadding.toDouble(),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              tr(LocaleKeys.fullName),
              style: context.textTheme().displayLarge?.copyWith(
                    color: context.colorScheme().secondary,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Text(
            tr(LocaleKeys.profession),
            style: context.textTheme().headlineSmall?.copyWith(
                  color: context.colorScheme().secondary,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              runSpacing: 10,
              children: [
                PrimaryTextButton(
                  onPressed: onContactMePressed,
                  title: tr(LocaleKeys.contactMe),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: onLinkedInPressed,
                        icon: Image.asset(
                          'assets/images/linkedin.png',
                        ),
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyles.secondaryIconButton(context),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: onGithubPressed,
                        icon: Image.asset(
                          'assets/images/github.png',
                        ),
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyles.secondaryIconButton(context),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            tr(LocaleKeys.introductionQuestion),
            style: context.textTheme().bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              tr(LocaleKeys.introducion),
              style: context.textTheme().bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
