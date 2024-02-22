import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/standard_horizontal_padding.dart';
import 'package:jamie_walker_website/generic/view/wrapping_cards_section.dart';
import 'package:jamie_walker_website/landing/services/jw_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'service_card.dart';

class ServicesSection extends StatelessWidget {
  static const double horizontalSpacing = 40;
  static const double verticalSpacing = 40;
  static const double minimumCardWidth = 340;
  static const int maximumCardsPerRow = 3;

  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardHorizontalPadding(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: JamieWalkerAppBar.preferredHeight,
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenSize.minimumPadding.toDouble(),
                  bottom: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr(LocaleKeys.servicesSectionTitleAlt),
                        style: context
                            .appTextStyles()
                            .sectionHeaderTextStyle(context),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: verticalSpacing,
                    ),
                    WrappingCardsSection(
                      horizontalSpacing: horizontalSpacing,
                      verticalSpacing: verticalSpacing,
                      minimumCardWidth: minimumCardWidth,
                      maximumCardsPerRow: maximumCardsPerRow,
                      children: JWService.values
                          .map((service) => _ServiceCard(service: service))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
