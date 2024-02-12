import 'dart:math';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/functional_extensions.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
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
  final _mainColumnKey = GlobalKey();
  late Map<LandingPageSection, GlobalKey> _sectionKeys;
  late Map<LandingPageSection, double?> _sectionColumnOffsets;
  int _currentLandingPageSectionIndex = 0;

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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _calculateSectionOffsets(),
    );
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Scrollbar(
              controller: _scrollController,
              interactive: true,
              child: Column(
                key: _mainColumnKey,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoScrollTag(
                    key: const ValueKey(LandingPageSection.home),
                    controller: _scrollController,
                    index: LandingPageSection.values.indexOf(
                      LandingPageSection.home,
                    ),
                    child: _WelcomeSection(
                      key: _sectionKeys[LandingPageSection.home],
                      onContactMePressed: () => _scrollToSection(
                        LandingPageSection.contact,
                      ),
                    ),
                  ),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  AutoScrollTag(
                    key: const ValueKey(LandingPageSection.services),
                    controller: _scrollController,
                    index: LandingPageSection.values.indexOf(
                      LandingPageSection.services,
                    ),
                    child: ServicesSection(
                      key: _sectionKeys[LandingPageSection.services],
                    ),
                  ),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  AutoScrollTag(
                    key: const ValueKey(LandingPageSection.testimonials),
                    controller: _scrollController,
                    index: LandingPageSection.values.indexOf(
                      LandingPageSection.testimonials,
                    ),
                    child: TestimonialsSection(
                      key: _sectionKeys[LandingPageSection.testimonials],
                    ),
                  ),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  AutoScrollTag(
                    key: const ValueKey(LandingPageSection.portfolio),
                    controller: _scrollController,
                    index: LandingPageSection.values.indexOf(
                      LandingPageSection.portfolio,
                    ),
                    child: PortfolioSection(
                      key: _sectionKeys[LandingPageSection.portfolio],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _scrollToSectionWithIndex(int index) {
    _scaffoldKey.currentState?.closeEndDrawer();
    final section = LandingPageSection.values[index];
    _scrollToSection(section);
  }

  void _scrollToSection(LandingPageSection section) {
    _scrollController.scrollToIndex(
      LandingPageSection.values.indexOf(section),
      duration: const Duration(milliseconds: 500),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  void _calculateSectionOffsets() {
    final mainColumnRenderBox =
        _mainColumnKey.currentContext?.findRenderObject() as RenderBox;
    _sectionColumnOffsets = {
      for (var section in LandingPageSection.values)
        section: () {
          final sectionKey = _sectionKeys[section];
          final renderBox = sectionKey?.currentContext
              ?.findRenderObject()
              ?.castOrNull<RenderBox>();
          if (renderBox == null) return null;
          final globalOffset = renderBox.localToGlobal(Offset.zero);
          return mainColumnRenderBox.globalToLocal(globalOffset).dy;
        }(),
    };
  }

  void _handleScrollCallback() {
    final currentOffset = _scrollController.offset;
    final sectionOffsetDifferences = _sectionColumnOffsets.map(
      (section, columnOffset) => MapEntry(
        section,
        columnOffset == null ? null : (columnOffset - currentOffset).abs(),
      ),
    );

    final double minSectionOffsetDifference =
        sectionOffsetDifferences.values.whereType<double>().min;
    final sectionOfMinOffset = sectionOffsetDifferences.entries
        .firstWhere(
          (element) => element.value == minSectionOffsetDifference,
        )
        .key;

    setState(() {
      _currentLandingPageSectionIndex = LandingPageSection.values.indexOf(
        sectionOfMinOffset,
      );
    });
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
          ? _WelcomeSectionMobile(onContactMePressed: onContactMePressed)
          : _WelcomeSectionDesktop(onContactMePressed: onContactMePressed),
    );
  }
}

class _WelcomeSectionDesktop extends StatelessWidget {
  static const double minHeight = 700;
  static const double maxHeight = 1000;

  final void Function() onContactMePressed;

  const _WelcomeSectionDesktop({
    required this.onContactMePressed,
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
              child: SelectionArea(
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
                            TextButton(
                              style: CustomButtonStyles.primaryActionButton(),
                              onPressed: onContactMePressed,
                              child: Text(tr(LocaleKeys.contactMe)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {},
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
                              onPressed: () {},
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
  final void Function() onContactMePressed;

  const _WelcomeSectionMobile({
    required this.onContactMePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.minimumPadding.toDouble(),
      ),
      child: SelectionArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
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
            Text(
              tr(LocaleKeys.fullName),
              style: CustomTextStyles.header1(),
              textAlign: TextAlign.center,
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
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    TextButton(
                      style: CustomButtonStyles.primaryActionButton(),
                      onPressed: onContactMePressed,
                      child: Text(tr(LocaleKeys.contactMe)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
      ),
    );
  }
}
