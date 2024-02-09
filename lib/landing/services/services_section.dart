part of '../view/landing_page.dart';

class _ServicesSection extends StatelessWidget {
  static const double cardSpacing = 40;
  static const double minimumCardWidth = 340;
  static const int maximumCardsPerRow = 3;

  const _ServicesSection();

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
                    Text(
                      tr(LocaleKeys.servicesSectionTitleAlt),
                      style: CustomTextStyles.header2(),
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
