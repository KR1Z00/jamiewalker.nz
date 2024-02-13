import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/wrapping_cards_section.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_repository.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_info_dialog.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_item_card.dart';

class PortfolioSection extends ConsumerWidget {
  static const double cardSpacing = 40;
  static const double minimumCardWidth = 400;
  static const int maximumCardsPerRow = 2;

  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioItems = ref.watch(portfolioRepositoryProvider);
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
                portfolioItems.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (data) => WrappingCardsSection(
                    cardSpacing: cardSpacing,
                    maximumCardsPerRow: maximumCardsPerRow,
                    minimumCardWidth: minimumCardWidth,
                    children: data
                        .map(
                          (portfolioItemModel) => PortfolioItemCard(
                            model: portfolioItemModel,
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return PortfolioInfoDialog(
                                  model: portfolioItemModel,
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  skipError: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
