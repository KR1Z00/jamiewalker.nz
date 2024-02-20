part of 'welcome_section.dart';

class _WelcomeSectionMobile extends StatelessWidget {
  static const double _maximumProfileImageWidth = 500;
  static const double _maximumProfileImageHeightRelativeToScreen = 0.4;

  final void Function() onContactMePressed;
  final void Function() onGithubPressed;
  final void Function() onLinkedInPressed;

  const _WelcomeSectionMobile({
    required this.onContactMePressed,
    required this.onGithubPressed,
    required this.onLinkedInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final profileImageWidth = min(
      _maximumProfileImageWidth,
      screenHeight * _maximumProfileImageHeightRelativeToScreen,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.minimumPadding.toDouble(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: profileImageWidth),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/profile_picture_square.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenSize.minimumPadding.toDouble(),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              tr(LocaleKeys.fullName),
              style: context.textTheme().displayLarge?.copyWith(
                    color: context.colorScheme().secondary,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Text(
            tr(LocaleKeys.profession),
            style: context.textTheme().headlineSmall?.copyWith(
                  color: context.colorScheme().secondary,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              runSpacing: 10,
              children: [
                PrimaryTextButton(
                  onPressed: onContactMePressed,
                  title: tr(LocaleKeys.contactMe),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: onLinkedInPressed,
                        icon: Image.asset(
                          'assets/images/linkedin.png',
                        ),
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyles.secondaryIconButton(context),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: onGithubPressed,
                        icon: Image.asset(
                          'assets/images/github.png',
                        ),
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyles.secondaryIconButton(context),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            tr(LocaleKeys.introductionQuestion),
            style: context.textTheme().bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              tr(LocaleKeys.introducion),
              style: context.textTheme().bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
