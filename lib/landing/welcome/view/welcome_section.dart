import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/generic/view/secondary_text_button.dart';
import 'package:jamie_walker_website/generic/view/standard_horizontal_padding.dart';
import 'package:jamie_walker_website/landing/welcome/view/arrow_down.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'welcome_section_desktop.dart';
part 'welcome_section_tablet.dart';
part 'welcome_section_mobile.dart';

class WelcomeSection extends StatelessWidget {
  static const double scrollDownGuidanceMaxHeight = 150;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;

  /// The amount of space to offset the screen height by when calculating the
  /// position of the scroll down guidance.
  final double screenHeightOffset;

  const WelcomeSection({
    super.key,
    required this.onContactMePressed,
    required this.onViewPortfolioPressed,
    required this.screenHeightOffset,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => _WelcomeSectionDesktop(
        onContactMePressed: onContactMePressed,
        onViewPortfolioPressed: onViewPortfolioPressed,
        onGithubPressed: _onGithubPressed,
        onLinkedInPressed: _onLinkedInPressed,
        screenHeightOffset: screenHeightOffset,
      ),
      tablet: (context) => _WelcomeSectionTablet(
        onContactMePressed: onContactMePressed,
        onViewPortfolioPressed: onViewPortfolioPressed,
        onGithubPressed: _onGithubPressed,
        onLinkedInPressed: _onLinkedInPressed,
        screenHeightOffset: screenHeightOffset,
      ),
      mobile: (context) => _WelcomeSectionMobile(
        onContactMePressed: onContactMePressed,
        onGithubPressed: _onGithubPressed,
        onLinkedInPressed: _onLinkedInPressed,
        onViewPortfolioPressed: onViewPortfolioPressed,
        screenHeightOffset: screenHeightOffset,
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
