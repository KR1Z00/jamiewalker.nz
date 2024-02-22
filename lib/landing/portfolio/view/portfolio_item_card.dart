import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/secondary_text_button.dart';
import 'package:jamie_walker_website/generic/view/tertiary_text_button.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PortfolioItemCard extends StatefulWidget {
  static const double imageAspectRatio = 4 / 3;
  static const double maxImageWidth = 500;
  static const double desktopPreviewDescriptionHeight = 140;
  static const double mobilePreviewDescriptionHeight = 80;
  static const double desktopPreviewTechnologiesHeight = 90;
  static const double mobilePreviewTechnologiesHeight = 60;

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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Align(
        alignment: Alignment.center,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) => setState(() {
            _isHovered = true;
          }),
          onExit: (event) => setState(() {
            _isHovered = false;
          }),
          child: GestureDetector(
            onTap: widget.onTap,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: !sizingInformation.isDesktop
                    ? PortfolioItemCard.maxImageWidth
                    : double.infinity,
              ),
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
                      aspectRatio: PortfolioItemCard.imageAspectRatio,
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
                            color: context.colorScheme().secondary,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: sizingInformation.isDesktop
                        ? PortfolioItemCard.desktopPreviewDescriptionHeight
                        : PortfolioItemCard.mobilePreviewDescriptionHeight,
                    child: Text(
                      widget.model.previewDescription,
                      style: context.appTextStyles().bodyTextStyle(context),
                    ),
                  ),
                  Text(
                    tr(LocaleKeys.technologiesUsed),
                    style: context.textTheme().titleSmall?.copyWith(
                          color: context.colorScheme().secondary,
                        ),
                  ),
                  SizedBox(
                    height: sizingInformation.isDesktop
                        ? PortfolioItemCard.desktopPreviewTechnologiesHeight
                        : PortfolioItemCard.mobilePreviewTechnologiesHeight,
                    child: Text(
                      widget.model.technologiesUsed,
                      style: context.appTextStyles().bodyTextStyle(context),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SecondaryTextButton(
                        title: sizingInformation.isDesktop
                            ? tr(LocaleKeys.clickToLearnMore)
                            : tr(LocaleKeys.tapToLearnMore),
                        onPressed: () => widget.onTap,
                      ),
                      if (widget.model.appStoreUrl != null)
                        TertiaryTextButton(
                          onPressed: () =>
                              launchUrlString(widget.model.appStoreUrl!),
                          title: tr(LocaleKeys.viewOnAppStore),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
