import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 100,
                      sigmaY: 100,
                    ),
                    child: Image.asset(
                      widget.model.previewImageAsset,
                    ),
                  ),
                ),
                ColoredBox(
                  color: Colors.white.withOpacity(
                    0.3,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
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
                            opacity: _isHovered ? 0.4 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const ColoredBox(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.model.name,
                        style: context.themeData().textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
