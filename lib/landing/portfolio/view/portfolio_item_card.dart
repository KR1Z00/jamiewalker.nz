import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';

class PortfolioItemCard extends StatefulWidget {
  static const double aspectRatio = 16 / 9;

  final PortfolioItemModel model;
  final void Function() onTap;

  const PortfolioItemCard({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  State<PortfolioItemCard> createState() => _PortfolioItemCardState();
}

class _PortfolioItemCardState extends State<PortfolioItemCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  StandardBoxShadows.regular(),
                ],
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          widget.model.previewImageAsset,
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _isHovered ? 1 : 0.3,
                        duration: const Duration(milliseconds: 200),
                        child: ColoredBox(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                widget.model.name,
                style: context.textTheme().headlineMedium?.copyWith(
                      color: CustomColors.secondaryColor.l1,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
