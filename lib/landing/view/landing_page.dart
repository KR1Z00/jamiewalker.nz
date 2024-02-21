import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/functional_extensions.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/landing/contact/view/contact_section.dart';
import 'package:jamie_walker_website/landing/footer/view/footer_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_section.dart';
import 'package:jamie_walker_website/landing/services/services_section.dart';
import 'package:jamie_walker_website/landing/testimonials/view/testimonials_section.dart';
import 'package:jamie_walker_website/landing/view/landing_page_sections.dart';
import 'package:jamie_walker_website/landing/welcome/view/welcome_section.dart';
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
      backgroundColor: context.colorScheme().background,
      extendBodyBehindAppBar: true,
      body: SelectionArea(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          itemCount: LandingPageSection.values.length + 1,
          separatorBuilder: (context, index) {
            final isSeparatorForFooter =
                index == LandingPageSection.values.length - 1;
            final double separatorOpacity = isSeparatorForFooter ? 0.5 : 1;
            return context.wrappedForHorizontalPosition(
              child: Container(
                height: 1,
                color: context.colorScheme().secondary.withOpacity(
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
                LandingPageSection.home => WelcomeSection(
                    key: _sectionKeys[LandingPageSection.home],
                    onContactMePressed: () => _scrollToSection(
                      LandingPageSection.contact,
                    ),
                    onViewPortfolioPressed: () => _scrollToSection(
                      LandingPageSection.portfolio,
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
