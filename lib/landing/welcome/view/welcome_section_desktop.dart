part of 'welcome_section.dart';

class _WelcomeSectionDesktop extends StatelessWidget {
  static const double minimumHeight = 660;
  static const double bottomPadding = 20;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  /// The amount of space to offset the screen height by when calculating the
  /// position of the scroll down guidance.
  final double screenHeightOffset;

  const _WelcomeSectionDesktop({
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
      minimumHeight,
      screenHeight - screenHeightOffset,
    );

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardHorizontalPadding(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(LocaleKeys.greeting),
                              style: context.textTheme().displaySmall?.copyWith(
                                    color: context.colorScheme().secondary,
                                  ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                tr(LocaleKeys.fullName),
                                maxLines: 1,
                                style: context
                                    .textTheme()
                                    .displayLarge
                                    ?.copyWith(
                                      color: context.colorScheme().secondary,
                                    ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                tr(LocaleKeys.profession).toUpperCase(),
                                style: context
                                    .textTheme()
                                    .displaySmall
                                    ?.copyWith(
                                      color: context.colorScheme().secondary,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              tr(LocaleKeys.introductionQuestion),
                              style: context
                                  .appTextStyles()
                                  .bodyTextStyle(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                tr(LocaleKeys.introducion),
                                style: context
                                    .appTextStyles()
                                    .bodyTextStyle(context),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    IconButton(
                                      onPressed: onLinkedInPressed,
                                      icon: Image.asset(
                                        'assets/images/linkedin.png',
                                      ),
                                      padding: EdgeInsets.zero,
                                      style: CustomButtonStyles
                                          .secondaryIconButton(context),
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
                                      style: CustomButtonStyles
                                          .secondaryIconButton(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                PrimaryTextButton(
                                  onPressed: onContactMePressed,
                                  title: tr(LocaleKeys.contactMe),
                                ),
                                const SizedBox(
                                  width: 20,
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
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/profile_picture.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: WelcomeSection.scrollDownGuidanceMaxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
