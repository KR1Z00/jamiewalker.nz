part of 'welcome_section.dart';

class _WelcomeSectionMobile extends StatelessWidget {
  static const double backgroundImageMinimumHeight = 150;
  static const double backgroundImageMaximumHeight = 250;
  static const double backgroundImageIdealHeightRatio = 1 / 3;

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Spacer(),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Scroll down to learn more",
                                style: context.textTheme().titleSmall?.copyWith(
                                      color: context.colorScheme().tertiary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
