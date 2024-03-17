part of 'welcome_section.dart';

class _WelcomeSectionMobile extends StatelessWidget {
  static const double minimumHeight = 580;
  static const double bottomPadding = 10;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  /// The amount of space to offset the screen height by when calculating the
  /// position of the scroll down guidance.
  final double screenHeightOffset;

  const _WelcomeSectionMobile({
    required this.onContactMePressed,
    required this.onViewPortfolioPressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
    required this.screenHeightOffset,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final height = max(
      screenHeight - screenHeightOffset,
      minimumHeight,
    );

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StandardHorizontalPadding(
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
            child: StandardHorizontalPadding(
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
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight:
                                    WelcomeSection.scrollDownGuidanceMaxHeight,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    tr(LocaleKeys.scrollDownGuidance),
                                    textAlign: TextAlign.center,
                                    style: context
                                        .textTheme()
                                        .titleSmall
                                        ?.copyWith(
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
