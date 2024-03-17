import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/functional_extensions.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/generic/loading/view/loading_fade_scale_in.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/landing/contact/view/contact_section.dart';
import 'package:jamie_walker_website/landing/footer/view/footer_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_section.dart';
import 'package:jamie_walker_website/landing/services/services_section.dart';
import 'package:jamie_walker_website/landing/testimonials/view/testimonials_section.dart';
import 'package:jamie_walker_website/landing/view/landing_page_sections.dart';
import 'package:jamie_walker_website/generic/loading/view/loading_fade_in.dart';
import 'package:jamie_walker_website/landing/welcome/view/welcome_section.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
  final GlobalKey<LoadingFadeInState> _appBarFadeInKey = GlobalKey();
  final GlobalKey<LoadingFadeInState> _backgroundImageFadeInKey = GlobalKey();
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

    _doLoadingFadeIn();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          JamieWalkerAppBar.preferredHeight,
        ),
        child: LoadingFadeIn(
          key: _appBarFadeInKey,
          shouldAnimate: true,
          child: JamieWalkerAppBar(
            navigationItemTitles: LandingPageSection.values
                .map((section) => section.title)
                .toList(),
            currentNavigationItemIndex: _currentLandingPageSectionIndex,
            onNavigationItemIndexPressed: _scrollToSectionWithIndex,
            onHamburgerPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ),
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

            if (section == LandingPageSection.home) {
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  double screenHeight = sizingInformation.screenSize.height;
                  double imageHeight;

                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.desktop) {
                    imageHeight = screenHeight / 3;
                    imageHeight = imageHeight.clamp(200.0, 500.0);
                  } else {
                    imageHeight = screenHeight / 4;
                    imageHeight = imageHeight.clamp(150.0, 250.0);
                  }

                  return AutoScrollTag(
                    controller: _scrollController,
                    index: index,
                    key: ValueKey(section),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadingFadeIn(
                          shouldAnimate: !hasLoadedBefore,
                          key: _backgroundImageFadeInKey,
                          child: Container(
                            width: double.infinity,
                            height: imageHeight,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/background.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        LoadingFadeScaleIn(
                          key: _sectionKeys[section],
                          shouldAnimate: !hasLoadedBefore,
                          child: WelcomeSection(
                            onContactMePressed: () => _scrollToSection(
                              LandingPageSection.contact,
                            ),
                            onViewPortfolioPressed: () => _scrollToSection(
                              LandingPageSection.portfolio,
                            ),
                            screenHeightOffset: imageHeight,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return AutoScrollTag(
                controller: _scrollController,
                index: index,
                key: ValueKey(section),
                child: LoadingFadeScaleIn(
                  key: _sectionKeys[section],
                  shouldAnimate: !hasLoadedBefore,
                  child: switch (section) {
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
                    LandingPageSection.home => Container(),
                  },
                ),
              );
            }
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
    final sectionYOffsets = _calculateSectionYOffsets();
    _updateCurrentSection(sectionYOffsets: sectionYOffsets);
    _loadInVisibleSections(sectionYOffsets: sectionYOffsets);
  }

  Map<LandingPageSection, double?> _calculateSectionYOffsets() {
    return _sectionKeys.map(
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
  }

  void _updateCurrentSection({
    required Map<LandingPageSection, double?> sectionYOffsets,
  }) {
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

  void _loadInVisibleSections({
    required Map<LandingPageSection, double?> sectionYOffsets,
  }) {
    final double fadeInOffset = MediaQuery.of(context).size.height -
        LandingPage.sectionfadeInOffsetFromBottom;
    for (final sectionEntry in sectionYOffsets.entries) {
      if (sectionEntry.value == null) {
        continue;
      }
      if (sectionEntry.value! < fadeInOffset) {
        _sectionKeys[sectionEntry.key]!
            .currentState
            ?.castOrNull<LoadingFadeScaleInState>()
            ?.startAnimation();
      }
    }
  }

  void _doLoadingFadeIn() {
    Future.delayed(
      const Duration(milliseconds: 50),
      () => _backgroundImageFadeInKey.currentState?.startAnimation(),
    );

    Future.delayed(
      const Duration(milliseconds: 450),
      () => _appBarFadeInKey.currentState?.startAnimation(),
    );

    Future.delayed(
      const Duration(milliseconds: 250),
      () => _loadInVisibleSections(
        sectionYOffsets: _calculateSectionYOffsets(),
      ),
    );
  }
}
