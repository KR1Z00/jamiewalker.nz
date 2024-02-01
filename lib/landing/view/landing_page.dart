import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';

part '../services/services_section.dart';
part '../services/service_card.dart';

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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey there!",
                        style: CustomTextStyles.header1(),
                      ),
                      Row(
                        children: [
                          const Text(
                            "My name is ",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Jamie Walker",
                            style: TextStyle(
                              fontSize: 24,
                              color: CustomColors.secondaryColor.l1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "I build cutting-edge mobile apps, producing highly satisfactory results for my valued clients to help their businesses grow.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
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
                                onPressed: () {},
                                child: const Text("Hire Me"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset('linkedin.png'),
                                padding: EdgeInsets.zero,
                                style: CustomButtonStyles.secondaryIconButton(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset('github.png'),
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
                  width: 40,
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
