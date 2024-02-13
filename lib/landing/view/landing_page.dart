import 'dart:math';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/functional_extensions.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/landing/contact/view/contact_section.dart';
import 'package:jamie_walker_website/landing/footer/view/footer_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_section.dart';
import 'package:jamie_walker_website/landing/services/services_section.dart';
import 'package:jamie_walker_website/landing/testimonials/view/testimonials_section.dart';
import 'package:jamie_walker_website/landing/view/landing_page_sections.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _scrollController = AutoScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late Map<LandingPageSection, GlobalKey> _sectionKeys;
  int _currentLandingPageSectionIndex = 0;

  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _messageTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScrollCallback);
    _sectionKeys = {
      for (var section in LandingPageSection.values) section: GlobalKey()
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_handleScrollCallback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: JamieWalkerNavigationDrawer(
        navigationItemTitles:
            LandingPageSection.values.map((section) => section.title).toList(),
        currentNavigationItemIndex: _currentLandingPageSectionIndex,
        onNavigationItemIndexPressed: _scrollToSectionWithIndex,
      ),
      appBar: JamieWalkerAppBar(
        navigationItemTitles:
            LandingPageSection.values.map((section) => section.title).toList(),
        currentNavigationItemIndex: _currentLandingPageSectionIndex,
        onNavigationItemIndexPressed: _scrollToSectionWithIndex,
        onHamburgerPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      backgroundColor: CustomColors.primaryColor.d2,
      body: SelectionArea(
        child: ListView.separated(
          controller: _scrollController,
          itemCount: LandingPageSection.values.length + 1,
          separatorBuilder: (context, index) {
            final isSeparatorForFooter =
                index == LandingPageSection.values.length - 1;
            final double separatorOpacity = isSeparatorForFooter ? 0.5 : 1;
            return context.wrappedForHorizontalPosition(
              child: Container(
                height: 1,
                color: CustomColors.secondaryColor.l1.withOpacity(
                  separatorOpacity,
                ),
              ),
            );
          },
          itemBuilder: (context, index) {
            if (index == LandingPageSection.values.length) {
              return const FooterSection();
            }

            final section = LandingPageSection.values[index];
            return AutoScrollTag(
              controller: _scrollController,
              index: index,
              key: ValueKey(section),
              child: switch (section) {
                LandingPageSection.home => _WelcomeSection(
                    key: _sectionKeys[LandingPageSection.home],
                    onContactMePressed: () => _scrollToSection(
                      LandingPageSection.contact,
                    ),
                  ),
                LandingPageSection.services => ServicesSection(
                    key: _sectionKeys[LandingPageSection.services],
                  ),
                LandingPageSection.portfolio => PortfolioSection(
                    key: _sectionKeys[LandingPageSection.portfolio],
                  ),
                LandingPageSection.testimonials => TestimonialsSection(
                    key: _sectionKeys[LandingPageSection.testimonials],
                  ),
                LandingPageSection.contact => ContactSection(
                    key: _sectionKeys[LandingPageSection.contact],
                    emailTextEditingController: _emailTextEditingController,
                    messageTextEditingController: _messageTextEditingController,
                    nameTextEditingController: _nameTextEditingController,
                  ),
              },
            );
          },
        ),
      ),
    );
  }

  void _scrollToSectionWithIndex(int index) {
    _scaffoldKey.currentState?.closeEndDrawer();
    final section = LandingPageSection.values[index];
    _scrollToSection(section);
  }

  void _scrollToSection(LandingPageSection section) {
    final index = LandingPageSection.values.indexOf(section);
    _scrollController.scrollToIndex(
      index,
      duration: const Duration(milliseconds: 500),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  void _handleScrollCallback() {
    final Map<LandingPageSection, double?> sectionYOffsets = _sectionKeys.map(
      (key, value) {
        final renderBox =
            value.currentContext?.findRenderObject()?.castOrNull<RenderBox>();
        if (renderBox == null) {
          return MapEntry(key, null);
        }
        final yLocation = renderBox.localToGlobal(Offset.zero).dy.abs();
        return MapEntry(key, yLocation);
      },
    );

    final double minYLocation =
        sectionYOffsets.values.whereType<double>().map((e) => e.abs()).min;

    final LandingPageSection? sectionOfMinYOffset =
        sectionYOffsets.keys.firstWhereOrNull(
      (element) => sectionYOffsets[element] == minYLocation,
    );

    if (sectionOfMinYOffset != null) {
      setState(() {
        _currentLandingPageSectionIndex = LandingPageSection.values.indexOf(
          sectionOfMinYOffset,
        );
      });
    }
  }
}

class _WelcomeSection extends StatelessWidget {
  final void Function() onContactMePressed;

  const _WelcomeSection({
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
                    style: CustomTextStyles.header1(),
                  ),
                  Text(
                    tr(LocaleKeys.profession),
                    style: CustomTextStyles.paragraph1(
                      color: CustomColors.secondaryColor.l1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      tr(LocaleKeys.introductionQuestion),
                      style: CustomTextStyles.paragraph2(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      tr(LocaleKeys.introducion),
                      style: CustomTextStyles.paragraph2(),
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
                            style: CustomButtonStyles.secondaryIconButton(),
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
                            style: CustomButtonStyles.secondaryIconButton(),
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
              style: CustomTextStyles.header1(),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Text(
            tr(LocaleKeys.profession),
            style: CustomTextStyles.paragraph1(
              fontStyle: FontStyle.italic,
              color: CustomColors.secondaryColor.l1,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                PrimaryTextButton(
                  onPressed: onContactMePressed,
                  title: tr(LocaleKeys.contactMe),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 40,
                  child: IconButton(
                    onPressed: onLinkedInPressed,
                    icon: Image.asset(
                      'assets/images/linkedin.png',
                    ),
                    padding: EdgeInsets.zero,
                    style: CustomButtonStyles.secondaryIconButton(),
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
                    style: CustomButtonStyles.secondaryIconButton(),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Text(
            tr(LocaleKeys.introductionQuestion),
            style: CustomTextStyles.paragraph3(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              tr(LocaleKeys.introducion),
              style: CustomTextStyles.paragraph3(),
            ),
          ),
        ],
      ),
    );
  }
}
