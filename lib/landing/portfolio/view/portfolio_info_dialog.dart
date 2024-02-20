import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/blurred_fitted_image.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';
import 'package:jamie_walker_website/landing/portfolio/domain/portfolio_item_info_view_model.dart';
import 'package:jamie_walker_website/landing/portfolio/view/portfolio_youtube_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PortfolioInfoDialog extends HookConsumerWidget {
  final PortfolioItemModel model;

  const PortfolioInfoDialog({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioItemInfoViewModelProvider(model));
    final currentPage = state.pages[state.currentPageIndex];
    final descriptionTextStyle =
        context.appTextStyles().bodyTextStyle(context).copyWith(
              color: context.colorScheme().onPrimaryContainer,
            );
    final scrollController = useScrollController();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: context.wrappedForHorizontalPosition(
        child: SelectionArea(
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
                    color: context.colorScheme().primaryContainer,
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
                              style: context.textTheme().displaySmall?.copyWith(
                                    color: context
                                        .colorScheme()
                                        .onPrimaryContainer,
                                  ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: FaIcon(
                                FontAwesomeIcons.xmark,
                                color: context.colorScheme().onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
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
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Scrollbar(
                                controller: scrollController,
                                thumbVisibility: true,
                                thickness: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Text(
                                    currentPage.description,
                                    style: descriptionTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: ref
                                  .read(
                                      portfolioItemInfoViewModelProvider(model)
                                          .notifier)
                                  .selectPreviousPage,
                              icon: FaIcon(
                                FontAwesomeIcons.chevronLeft,
                                color: context.colorScheme().onPrimaryContainer,
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
                                    dotColor: context
                                        .colorScheme()
                                        .onPrimaryContainer
                                        .withOpacity(0.3),
                                    activeDotColor: context
                                        .colorScheme()
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: ref
                                  .read(
                                      portfolioItemInfoViewModelProvider(model)
                                          .notifier)
                                  .selectNextPage,
                              icon: FaIcon(
                                FontAwesomeIcons.chevronRight,
                                color: context.colorScheme().onPrimaryContainer,
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
