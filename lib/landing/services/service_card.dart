part of 'services_section.dart';

class _ServiceCard extends StatelessWidget {
  static const double desktopHeight = 300;
  static const double mobileHeight = 270;

  final JWService service;

  const _ServiceCard({required this.service});

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
        style: CustomTextStyles.header2(),
      );
    }

    final title = serviceStrings["serviceName"];
    final description = serviceStrings["serviceDescription"];
    final skills = serviceStrings["serviceSkills"];

    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.d1,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          StandardBoxShadows.regular(),
        ],
      ),
      child: SizedBox(
        height: context.layoutForMobile() ? mobileHeight : desktopHeight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SelectionArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        _imageAssetForService(
                          service,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: CustomTextStyles.header3(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    skills,
                    style: CustomTextStyles.paragraph3(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
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
