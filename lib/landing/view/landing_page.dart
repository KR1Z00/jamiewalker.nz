import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/functional_extensions.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/landing/contact/view/contact_section.dart';
import 'package:jamie_walker_website/landing/footer/view/footer_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_section.dart';
import 'package:jamie_walker_website/landing/services/services_section.dart';
import 'package:jamie_walker_website/landing/testimonials/view/testimonials_section.dart';
import 'package:jamie_walker_website/landing/view/landing_page_sections.dart';
import 'package:jamie_walker_website/landing/view/loading_fade_in.dart';
import 'package:jamie_walker_website/landing/welcome/view/welcome_section.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LandingPage extends StatefulWidget {
  static const double sectionfadeInOffsetFromBottom = 300;

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _scrollController = AutoScrollController();
  int _currentLandingPageSectionIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late Map<LandingPageSection, GlobalKey> _sectionKeys;
  late Map<LandingPageSection, bool> _sectionHasLoadedMap;

  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _messageTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScrollCallback);
    _sectionKeys = {
      for (var section in LandingPageSection.values) section: GlobalKey(),
    };
    _sectionHasLoadedMap = {
      for (var section in LandingPageSection.values) section: false,
    };

    Future.delayed(
      const Duration(milliseconds: 50),
      () => _handleScrollCallback(),
    );
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
      backgroundColor: context.colorScheme().background,
      extendBodyBehindAppBar: true,
      body: SelectionArea(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          itemCount: LandingPageSection.values.length + 1,
          itemBuilder: (context, index) {
            if (index == LandingPageSection.values.length) {
              return const FooterSection();
            }

            final section = LandingPageSection.values[index];
            final hasLoadedBefore = _sectionHasLoadedMap[section]!;
            if (!hasLoadedBefore) {
              _sectionHasLoadedMap[section] = true;
            }

            return AutoScrollTag(
              controller: _scrollController,
              index: index,
              key: ValueKey(section),
              child: LoadingFadeIn(
                key: _sectionKeys[section],
                hasLoadedBefore: hasLoadedBefore,
                child: switch (section) {
                  LandingPageSection.home => WelcomeSection(
                      onContactMePressed: () => _scrollToSection(
                        LandingPageSection.contact,
                      ),
                      onViewPortfolioPressed: () => _scrollToSection(
                        LandingPageSection.portfolio,
                      ),
                    ),
                  LandingPageSection.services => const ServicesSection(),
                  LandingPageSection.portfolio => const PortfolioSection(),
                  LandingPageSection.testimonials =>
                    const TestimonialsSection(),
                  LandingPageSection.contact => ContactSection(
                      emailTextEditingController: _emailTextEditingController,
                      messageTextEditingController:
                          _messageTextEditingController,
                      nameTextEditingController: _nameTextEditingController,
                    ),
                },
              ),
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

    final double fadeInOffset = MediaQuery.of(context).size.height -
        LandingPage.sectionfadeInOffsetFromBottom;
    for (final sectionEntry in sectionYOffsets.entries) {
      if (sectionEntry.value == null) {
        continue;
      }
      if (sectionEntry.value! < fadeInOffset) {
        _sectionKeys[sectionEntry.key]!
            .currentState
            ?.castOrNull<LoadingFadeInState>()
            ?.fadeIn();
      }
    }

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
