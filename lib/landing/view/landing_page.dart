import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';
import 'package:jamie_walker_website/landing/services/jw_service.dart';
import 'package:jamie_walker_website/landing/testimonials/data/testimonials_repository.dart';
import 'package:jamie_walker_website/landing/testimonials/domain/testimonials_section_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part '../services/services_section.dart';
part '../services/service_card.dart';
part '../testimonials/view/testimonials_section.dart';

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
                  const _TestimonialsSection(),
                  context.wrappedForHorizontalPosition(
                    child: Container(
                      color: CustomColors.secondaryColor.l1,
                      height: 1,
                    ),
                  ),
                  const _ServicesSection(),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'profile_picture_square.jpg',
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
