import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

class PortfolioItemCard extends StatefulWidget {
  static const double aspectRatio = 16 / 9;

  const PortfolioItemCard({super.key});

  @override
  State<PortfolioItemCard> createState() => _PortfolioItemCardState();
}

class _PortfolioItemCardState extends State<PortfolioItemCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: CustomColors.primaryColor.m,
          ),
        ),
      ),
    );
  }
}
