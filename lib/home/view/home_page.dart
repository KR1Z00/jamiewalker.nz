import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JamieWalkerAppBar(
        currentRoute: JamieWalkerRoute.home,
      ),
      body: Container(
        color: CustomColors.primaryColor.d2,
      ),
    );
  }
}
