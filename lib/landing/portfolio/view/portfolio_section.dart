import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
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
      child: Column(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr(LocaleKeys.portfolioSectionTitleAlt),
                    style:
                        context.appTextStyles().sectionHeaderTextStyle(context),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
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
          ),
        ],
      ),
    );
  }
}
