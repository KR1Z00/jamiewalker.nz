import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/blurred_fitted_image.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';
import 'package:jamie_walker_website/landing/portfolio/domain/portfolio_item_info_view_model.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_youtube_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PortfolioInfoDialog extends ConsumerWidget {
  final PortfolioItemModel model;

  const PortfolioInfoDialog({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioItemInfoViewModelProvider(model));
    final currentPage = state.pages[state.currentPageIndex];

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: context.wrappedForHorizontalPosition(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenSize.minimumPadding.toDouble(),
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(maxWidth: 1700),
                decoration: BoxDecoration(
                  color: CustomColors.primaryColor.l2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name,
                            style: CustomTextStyles.header3(
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const FaIcon(
                              FontAwesomeIcons.xmark,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: constraints.maxHeight * 0.5,
                          ),
                          child: _buildPageVisualContent(currentPage),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbVisibility: MaterialStateProperty.all(
                              true,
                            ),
                            thumbColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        child: Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: SingleChildScrollView(
                              child: Scrollbar(
                                thumbVisibility: true,
                                thickness: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Text(
                                    currentPage.description,
                                    style: CustomTextStyles.paragraph2(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: ref
                                .read(portfolioItemInfoViewModelProvider(model)
                                    .notifier)
                                .selectPreviousPage,
                            icon: const FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: state.currentPageIndex,
                                count: state.pages.length,
                                effect: WormEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  dotColor: CustomColors.primaryColor
                                      .withOpacity(0.3),
                                  activeDotColor: CustomColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: ref
                                .read(portfolioItemInfoViewModelProvider(model)
                                    .notifier)
                                .selectNextPage,
                            icon: const FaIcon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageVisualContent(PortfolioItemInfoPage currentPage) {
    switch (currentPage.contentType) {
      case PortfolioItemInfoPageContentType.image:
        {
          if (currentPage.imageAsset != null) {
            return BlurredFittedImage(
              asset: currentPage.imageAsset!,
            );
          }
        }
      case PortfolioItemInfoPageContentType.video:
        {
          if (currentPage.youtubeVideoId != null) {
            return PortfolioYoutubePlayer(
              youtubeVideoId: currentPage.youtubeVideoId!,
            );
          }
        }
    }

    return Container();
  }
}
