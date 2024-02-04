part of '../view/landing_page.dart';

class _ServicesSection extends StatelessWidget {
  static const double cardSpacing = 40;

  static const minimumWidthForThreeItemsPerRow = 1100;
  static const minimumWidthForTwoItemsPerRow = 700;

  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: LayoutBuilder(
        builder: (context, constraints) {
          int itemsPerRow = 1;
          if (constraints.maxWidth > minimumWidthForThreeItemsPerRow) {
            itemsPerRow = 3;
          } else if (constraints.maxWidth > minimumWidthForTwoItemsPerRow) {
            itemsPerRow = 2;
          }

          final numberOfSpacings = itemsPerRow - 1;
          final totalSpacing = numberOfSpacings * cardSpacing;
          final itemWidth = (constraints.maxWidth - totalSpacing) / itemsPerRow;

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenSize.minimumPadding.toDouble(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr(LocaleKeys.servicesSectionTitleAlt),
                      style: CustomTextStyles.header2(),
                    ),
                    const SizedBox(
                      height: cardSpacing,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: cardSpacing,
                      runSpacing: cardSpacing,
                      children: JWService.values
                          .map(
                            (service) => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: itemWidth,
                              ),
                              child: _ServiceCard(service: service),
                            ),
                          )
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
