import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';

class HomeSection extends StatelessWidget {
  static const double maxImageHeight = 700;
  // final double backgroundImageHeight;

  const HomeSection({
    super.key,
    // required this.backgroundImageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final backgroundImageHeight = min(
      maxImageHeight,
      screenHeight * 0.4,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.8),
      child: ColoredBox(
        color: context.themeData().colorScheme.background,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: backgroundImageHeight,
              child: Opacity(
                opacity: 0.7,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/images/background.jpg',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: context.wrappedForHorizontalPosition(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final sectionWidth = constraints.maxWidth / 2;
                    final imageSize = sectionWidth * 0.8;
                    final imageTopPadding =
                        backgroundImageHeight - imageSize / 3;

                    final imageOverlapHeight =
                        backgroundImageHeight - imageTopPadding;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: backgroundImageHeight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      height: imageOverlapHeight,
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: ColoredBox(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            child: Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Spacer(),
                                                  Text(
                                                    tr(LocaleKeys.fullName),
                                                    style: context
                                                        .themeData()
                                                        .textTheme
                                                        .displayLarge,
                                                  ),
                                                  Text(
                                                    "${tr(LocaleKeys.profession)}, ${tr(LocaleKeys.location)}",
                                                    style: context
                                                        .themeData()
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: imageSize - imageOverlapHeight,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Text(
                                          tr(LocaleKeys.introductionQuestion),
                                          style: context
                                              .themeData()
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          tr(LocaleKeys.introducion),
                                          style: context
                                              .themeData()
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 60,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              style: CustomButtonStyles
                                                  .primaryActionButton(
                                                context,
                                              ),
                                              onPressed: () {},
                                              child:
                                                  Text(tr(LocaleKeys.hireMe)),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                  'assets/images/linkedin.png',
                                                  color: context
                                                      .themeData()
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                                padding: EdgeInsets.zero,
                                                style: CustomButtonStyles
                                                    .secondaryIconButton(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                  'assets/images/github.png',
                                                  color: context
                                                      .themeData()
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                                padding: EdgeInsets.zero,
                                                style: CustomButtonStyles
                                                    .secondaryIconButton(
                                                  context,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: imageTopPadding),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    StandardBoxShadows.light(),
                                  ],
                                ),
                                constraints: BoxConstraints.tight(
                                    Size.square(imageSize)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/images/profile_picture_square.jpg',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
