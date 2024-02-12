import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/landing/home/view/home_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_section.dart';
import 'package:jamie_walker_website/landing/services/services_section.dart';
import 'package:jamie_walker_website/landing/testimonials/view/testimonials_section.dart';

class LandingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const JamieWalkerNavigationDrawer(
        currentRoute: JamieWalkerRoute.home,
      ),
      appBar: JamieWalkerAppBar(
        currentRoute: JamieWalkerRoute.home,
        onHamburgerPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Scrollbar(
          interactive: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeSection(),
              const ServicesSection(),
              context.wrappedForHorizontalPosition(child: const Divider()),
              const TestimonialsSection(),
              context.wrappedForHorizontalPosition(child: const Divider()),
              const PortfolioSection(),
            ],
          ),
        ),
      ),
    );
  }
}
