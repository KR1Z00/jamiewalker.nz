import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/generic/view/secondary_text_button.dart';

class WelcomeSection extends StatelessWidget {
  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;

  const WelcomeSection({
    super.key,
    required this.onContactMePressed,
    required this.onViewPortfolioPressed,
  });

  @override
  Widget build(BuildContext context) {
    return context.layoutForMobile()
        ? _WelcomeSectionMobile(
            onContactMePressed: onContactMePressed,
            onGithubPressed: _onGithubPressed,
            onLinkedInPressed: _onLinkedInPressed,
          )
        : _WelcomeSectionDesktop(
            onContactMePressed: onContactMePressed,
            onViewPortfolioPressed: onViewPortfolioPressed,
            onGithubPressed: _onGithubPressed,
            onLinkedInPressed: _onLinkedInPressed,
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
  static const double backgroundImageMinimumHeight = 200;
  static const double backgroundImageMaximumHeight = 500;
  static const double backgroundImageIdealHeightRatio = 1 / 3;
  static const double welcomeContentMinimumHeight = 600;
  static const double welcomeContentMaximumHeight = 800;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionDesktop({
    required this.onContactMePressed,
    required this.onViewPortfolioPressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = max(
      min(
        backgroundImageMaximumHeight,
        (screenHeight * backgroundImageIdealHeightRatio),
      ),
      backgroundImageMinimumHeight,
    );

    final contentHeight = max(
      welcomeContentMinimumHeight,
      min(
        screenHeight - imageHeight,
        welcomeContentMaximumHeight,
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: imageHeight,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "assets/images/background.jpg",
              ),
            ),
          ),
          context.wrappedForHorizontalPosition(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: contentHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr(LocaleKeys.greeting),
                                style: context
                                    .textTheme()
                                    .displaySmall
                                    ?.copyWith(
                                      color: context.colorScheme().secondary,
                                    ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  tr(LocaleKeys.fullName),
                                  maxLines: 1,
                                  style: context
                                      .textTheme()
                                      .displayLarge
                                      ?.copyWith(
                                        color: context.colorScheme().secondary,
                                      ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  tr(LocaleKeys.profession).toUpperCase(),
                                  style: context
                                      .textTheme()
                                      .displaySmall
                                      ?.copyWith(
                                        color: context.colorScheme().secondary,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                tr(LocaleKeys.introductionQuestion),
                                style: context
                                    .appTextStyles()
                                    .bodyTextStyle(context),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  tr(LocaleKeys.introducion),
                                  style: context
                                      .appTextStyles()
                                      .bodyTextStyle(context),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: SizedBox(
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      IconButton(
                                        onPressed: onLinkedInPressed,
                                        icon: Image.asset(
                                          'assets/images/linkedin.png',
                                        ),
                                        padding: EdgeInsets.zero,
                                        style: CustomButtonStyles
                                            .secondaryIconButton(context),
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
                                        style: CustomButtonStyles
                                            .secondaryIconButton(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  PrimaryTextButton(
                                    onPressed: onContactMePressed,
                                    title: tr(LocaleKeys.contactMe),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SecondaryTextButton(
                                    onPressed: onViewPortfolioPressed,
                                    title: tr(LocaleKeys.viewPortfolio),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            'assets/images/profile_picture.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
