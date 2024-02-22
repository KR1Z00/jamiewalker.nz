part of 'services_section.dart';

class _ServiceCard extends StatelessWidget {
  final JWService service;

  const _ServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Refactor this using riverpod
    final List<Map<String, dynamic>> allServices =
        trList(context.locale, LocaleKeys.services);
    final Map<String, dynamic>? serviceStrings = allServices.firstWhereOrNull(
      (element) => element["key"] == service.name,
    );

    if (serviceStrings == null) {
      return Text(
        "ERROR",
        style: context.appTextStyles().sectionHeaderTextStyle(context),
      );
    }

    final title = serviceStrings["serviceName"];
    final skills = serviceStrings["serviceSkills"];
    final description = serviceStrings["description"];
    final imageAsset = _imageAssetForService(service);

    return ScreenTypeLayout.builder(
      desktop: (context) => _ServiceCardDesktop(
        title: title,
        description: description,
        skills: skills,
        imageAsset: imageAsset,
      ),
      mobile: (context) => _ServiceCardMobile(
        title: title,
        description: description,
        skills: skills,
        imageAsset: imageAsset,
      ),
    );
  }

  String _imageAssetForService(JWService service) {
    return switch (service) {
      JWService.ios => "assets/images/services/ios.png",
      JWService.flutter => "assets/images/services/flutter.png",
      JWService.backends => "assets/images/services/firebase.png",
    };
  }
}

class _ServiceCardMobile extends StatelessWidget {
  static const double imageSize = 80;

  final String title;
  final String description;
  final String skills;
  final String imageAsset;

  const _ServiceCardMobile({
    required this.title,
    required this.description,
    required this.skills,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme().surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          StandardBoxShadows.regular(),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: imageSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imageAsset),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: context.textTheme().headlineMedium?.copyWith(
                                color: context.colorScheme().secondary,
                              ),
                        ),
                      ),
                      Text(
                        description,
                        style: context.textTheme().labelSmall?.copyWith(
                              color: context.colorScheme().secondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              skills,
              style: context.appTextStyles().bodyTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCardDesktop extends StatelessWidget {
  static const double preferredHeight = 340;
  static const double imageSize = 120;

  final String title;
  final String description;
  final String skills;
  final String imageAsset;

  const _ServiceCardDesktop({
    required this.title,
    required this.description,
    required this.skills,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme().surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          StandardBoxShadows.regular(),
        ],
      ),
      child: SizedBox(
        height: preferredHeight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: imageSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imageAsset),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: context.textTheme().headlineMedium?.copyWith(
                        color: context.colorScheme().secondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  description,
                  style: context.textTheme().labelMedium?.copyWith(
                        color: context.colorScheme().secondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),
                Text(
                  tr(LocaleKeys.applicableSkills),
                  style: context.textTheme().labelMedium?.copyWith(
                        color: context.colorScheme().secondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  skills,
                  style: context.textTheme().bodyMedium?.copyWith(
                        color: context.colorScheme().onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
