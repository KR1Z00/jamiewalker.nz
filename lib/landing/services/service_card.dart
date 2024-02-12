part of 'services_section.dart';

class _ServiceCard extends StatelessWidget {
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
        style: context.themeData().textTheme.displayMedium,
      );
    }

    final title = serviceStrings["serviceName"];
    final description = serviceStrings["serviceDescription"];
    final skills = serviceStrings["serviceSkills"];

    return Card(
      // decoration: BoxDecoration(
      //   color: CustomColors.primaryColor.d1,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SelectionArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    _imageAssetForService(
                      service,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: context.themeData().textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  skills,
                  style: context.themeData().textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _imageAssetForService(JWService service) {
    return switch (service) {
      JWService.ios => "assets/images/ios.png",
      JWService.flutter => "assets/images/flutter.png",
      JWService.backends => "assets/images/firebase.png",
    };
  }
}
