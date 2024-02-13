import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
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
            padding: EdgeInsets.symmetric(
              vertical: ScreenSize.minimumPadding.toDouble(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        tr(LocaleKeys.servicesSectionTitleAlt),
                        style: CustomTextStyles.header2(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
