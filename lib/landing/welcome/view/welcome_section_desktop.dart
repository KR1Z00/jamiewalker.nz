part of 'welcome_section.dart';

class _WelcomeSectionDesktop extends StatelessWidget {
  static const double backgroundImageMinimumHeight = 200;
  static const double backgroundImageMaximumHeight = 500;
  static const double backgroundImageIdealHeightRatio = 1 / 3;
  static const double welcomeContentMinimumHeight = 600;
  static const double welcomeContentMaximumHeight = 800;

  final void Function() onContactMePressed;
  final void Function() onViewPortfolioPressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionDesktop({
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

    final contentHeight = max(
      welcomeContentMinimumHeight,
      min(
        screenHeight - imageHeight,
        welcomeContentMaximumHeight,
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: contentHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
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
                                style: context
                                    .textTheme()
                                    .displaySmall
                                    ?.copyWith(
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
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            'assets/images/profile_picture.png',
                          ),
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
    );
  }
}
