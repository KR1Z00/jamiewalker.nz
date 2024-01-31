import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/mobile_size.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_navigation_drawer.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  HomePage({super.key});

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
                    constraints: constraints,
                    color: CustomColors.primaryColor.d2,
                    child: const _WelcomeSection(),
                  ),
                  Container(
                    constraints: constraints,
                    color: CustomColors.primaryColor.l1,
                  ),
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
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey there!",
                  style: TextStyle(
                    fontSize: 64,
                    color: CustomColors.secondaryColor.l1,
                    fontWeight: FontWeight.bold,
                  ),
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
                    "I build cutting-edge mobile apps, producing highly satisfactory results for my valued clients to help their business grow.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: TextButton(
                    style: CustomButtonStyles.primaryActionButton(),
                    onPressed: () {},
                    child: const Text("Hire Me"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size.square(600)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.asset('profile_picture_square.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
