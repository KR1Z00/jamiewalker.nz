import 'package:flutter/material.dart';

class WrappingCardsSection extends StatelessWidget {
  /// The spacing with which the cards should be separated
  final double cardSpacing;

  /// The maximum number of cards per row in the section
  final int maximumCardsPerRow;

  /// The minimum width of each card in the section
  final double minimumCardWidth;

  /// The list of card item children to be wrapped
  final List<Widget> children;

  const WrappingCardsSection({
    super.key,
    required this.cardSpacing,
    required this.maximumCardsPerRow,
    required this.minimumCardWidth,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentWidth = constraints.maxWidth;
        final itemWidth = calculateItemWidthGiven(currentWidth: currentWidth);

        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: cardSpacing,
          runSpacing: cardSpacing,
          children: children
              .map(
                (child) => ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: itemWidth,
                  ),
                  child: child,
                ),
              )
              .toList(),
        );
      },
    );
  }

  /// Returns the maximum width by which to constrain each child item, so that
  /// they evenly distribute across the [currentWidth] of [this] widget
  @visibleForTesting
  double calculateItemWidthGiven({required double currentWidth}) {
    final itemsPerRow = calculateItemsPerRowGiven(currentWidth: currentWidth);
    final spacingsPerRow = itemsPerRow - 1;
    final widthWithoutSpacings = currentWidth - (spacingsPerRow * cardSpacing);
    return widthWithoutSpacings / itemsPerRow;
  }

  /// Returns the number of items to be placed horizontally given the
  /// [currentWidth]
  @visibleForTesting
  int calculateItemsPerRowGiven({required double currentWidth}) {
    int toReturn = 1;

    final widthThresholds = calculateWidthThresholdsForRowCounts().indexed;
    for (final (index, minimumWidth) in widthThresholds) {
      if (currentWidth >= minimumWidth) {
        /// The width thresholds list contains the minimum width for each number
        /// of row items, starting from 2
        final rowsPerItem = index + 2;
        toReturn = rowsPerItem;
      }
    }

    if (children.length < toReturn) {
      toReturn = children.length;
    }

    return toReturn;
  }

  /// Calculates the minimum width [this] widget should be, for each possible
  /// number of cards per row in the [Wrap], from 2 up to the [maximumCardsPerRow].
  ///
  /// For example:
  ///   - if [cardSpacing] == 40
  ///   - if [maximumCardsPerRow] == 4
  ///   - if [minimumCardWidth] == 100
  ///
  /// This function will return the following list:
  /// [240, 380, 520]
  ///
  /// because:
  ///
  /// - a width of 240 means that 2 card items can have a minimum width of 100,
  ///   separated by 40dp.
  /// - a width of 380 means that 3 card items can have a minimum width of 100,
  ///   separated by 40dp.
  /// - a width of 520 means that 4 card items can have a minimum width of 100,
  ///   separated by 40dp.
  @visibleForTesting
  List<double> calculateWidthThresholdsForRowCounts() {
    final possibleRowCounts = List<int>.generate(
      maximumCardsPerRow,
      (i) => i + 1,
    ).skip(1);

    return possibleRowCounts.map<double>((possibleRowCount) {
      final numberOfSpacings = possibleRowCount - 1;
      final sumOfCardWidths = possibleRowCount * minimumCardWidth;
      final sumOfSpacingWidths = numberOfSpacings * cardSpacing;
      return sumOfCardWidths + sumOfSpacingWidths;
    }).toList();
  }
}
