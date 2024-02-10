import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
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
      backgroundColor: CustomColors.primaryColor.d2,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Scrollbar(
              interactive: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: min(
                        constraints.maxHeight - ScreenSize.minimumPadding,
                        _WelcomeSection.maxHeight,
                      ),
                    ),
                    color: CustomColors.primaryColor.d2,
                    child: const _WelcomeSection(),
                  ),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  const TestimonialsSection(),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  const PortfolioSection(),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  const ServicesSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  static const double maxHeight = 1200;

  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text.rich(
                            TextSpan(
                              text: tr(
                                LocaleKeys.profession,
                              ),
                              style: CustomTextStyles.paragraph1(
                                color: CustomColors.secondaryColor.l1,
                              ),
                              children: [
                                TextSpan(
                                  text: " | ",
                                  style: CustomTextStyles.paragraph1(),
                                ),
                                TextSpan(
                                  text: tr(LocaleKeys.location),
                                  style: CustomTextStyles.paragraph1(
                                    color: CustomColors.secondaryColor.l1,
                                  ),
                                ),
                              ],
                            ),
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
                                  style:
                                      CustomButtonStyles.primaryActionButton(),
                                  onPressed: () {},
                                  child: Text(tr(LocaleKeys.hireMe)),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('linkedin.png'),
                                  padding: EdgeInsets.zero,
                                  style:
                                      CustomButtonStyles.secondaryIconButton(),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('github.png'),
                                  padding: EdgeInsets.zero,
                                  style:
                                      CustomButtonStyles.secondaryIconButton(),
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
                        'profile_picture_square.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
