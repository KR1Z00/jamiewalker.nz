import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/wrapping_cards_section.dart';
import 'package:jamie_walker_website/landing/services/jw_service.dart';

part 'service_card.dart';

class ServicesSection extends StatelessWidget {
  static const double cardSpacing = 40;
  static const double minimumCardWidth = 340;
  static const int maximumCardsPerRow = 3;

  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 80,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr(LocaleKeys.servicesSectionTitleAlt),
                  style: context.themeData().textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: cardSpacing,
                ),
                WrappingCardsSection(
                  cardSpacing: cardSpacing,
                  minimumCardWidth: minimumCardWidth,
                  maximumCardsPerRow: maximumCardsPerRow,
                  children: JWService.values
                      .map((service) => _ServiceCard(service: service))
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
