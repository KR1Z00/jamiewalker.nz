part of 'welcome_section.dart';

class _WelcomeSectionMobile extends StatelessWidget {
  static const double backgroundImageMinimumHeight = 150;
  static const double backgroundImageMaximumHeight = 250;
  static const double backgroundImageIdealHeightRatio = 1 / 4;
  static const double minimumHeight = 730;
  static const double bottomPadding = 20;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionMobile({
    required this.onContactMePressed,
    required this.onViewPortfolioPressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = max(
      min(
        backgroundImageMaximumHeight,
        (screenHeight * backgroundImageIdealHeightRatio),
      ),
      backgroundImageMinimumHeight,
    );

    final height = bottomPadding +
        max(
          screenHeight,
          minimumHeight,
        );

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: imageHeight,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "assets/images/background.jpg",
              ),
            ),
          ),
          context.wrappedForHorizontalPosition(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(LocaleKeys.greeting),
                    style: context.textTheme().headlineSmall?.copyWith(
                          color: context.colorScheme().secondary,
                        ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tr(LocaleKeys.fullName),
                      maxLines: 1,
                      style: context.textTheme().displayLarge?.copyWith(
                            color: context.colorScheme().secondary,
                          ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tr(LocaleKeys.profession).toUpperCase(),
                      style: context.textTheme().headlineSmall?.copyWith(
                            color: context.colorScheme().secondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: context.wrappedForHorizontalPosition(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(LocaleKeys.introductionQuestion),
                          style: context.appTextStyles().bodyTextStyle(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            tr(LocaleKeys.introducion),
                            style:
                                context.appTextStyles().bodyTextStyle(context),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            PrimaryTextButton(
                              onPressed: onContactMePressed,
                              title: tr(LocaleKeys.contactMe),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SecondaryTextButton(
                              onPressed: onViewPortfolioPressed,
                              title: tr(LocaleKeys.viewPortfolio),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/profile_picture_square.png',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: onLinkedInPressed,
                                icon: Image.asset(
                                  'assets/images/linkedin.png',
                                ),
                                padding: EdgeInsets.zero,
                                style: CustomButtonStyles.secondaryIconButton(
                                    context),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: onGithubPressed,
                                icon: Image.asset(
                                  'assets/images/github.png',
                                ),
                                padding: EdgeInsets.zero,
                                style: CustomButtonStyles.secondaryIconButton(
                                    context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          tr(LocaleKeys.scrollDownGuidance),
                          textAlign: TextAlign.center,
                          style: context.textTheme().titleSmall?.copyWith(
                                color: context.colorScheme().tertiary,
                              ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ArrowDown(
                            color: context.colorScheme().tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: bottomPadding,
          ),
        ],
      ),
    );
  }
}
