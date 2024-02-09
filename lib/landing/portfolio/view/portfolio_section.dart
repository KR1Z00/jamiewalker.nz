import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/wrapping_cards_section.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_item_card.dart';

class PortfolioSection extends StatelessWidget {
  static const double cardSpacing = 40;
  static const double minimumCardWidth = 400;
  static const int maximumCardsPerRow = 2;

  const PortfolioSection({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr(LocaleKeys.portfolioSectionTitleAlt),
                  style: CustomTextStyles.header2(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: cardSpacing,
                ),
                WrappingCardsSection(
                  cardSpacing: cardSpacing,
                  maximumCardsPerRow: maximumCardsPerRow,
                  minimumCardWidth: minimumCardWidth,
                  children: List.generate(
                    3,
                    (index) => const PortfolioItemCard(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
