part of '../view/landing_page.dart';

class _ServiceCard extends StatelessWidget {
  final JWService service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.d1,
        borderRadius: BorderRadius.circular(10),
      ),
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
                    color: CustomColors.primaryColor.l2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _titleForService(service),
                  style: CustomTextStyles.header3(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _descriptionForService(service),
                  style: CustomTextStyles.paragraph2(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Applicable Skills",
                  style: CustomTextStyles.header4(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _skillsForService(service),
                  style: CustomTextStyles.paragraph3(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _titleForService(JWService service) {
    return switch (service) {
      JWService.ios => "Native iOS Development",
      JWService.flutter => "Flutter Development",
      JWService.firebase => "Cloud Backends",
    };
  }

  String _descriptionForService(JWService service) {
    return switch (service) {
      JWService.ios => """
Provide your customers with a refined user experience that integrates seamlessly across the Apple ecosystem of devices.

Create solutions that harness the powerful native frameworks of the iOS and macOS SDKs.
""",
      JWService.flutter => """
Build amazing apps that can easily be deployed on multiple platforms including iOS, Android, Mac, Windows, and Web.

Enable rapid development and efficient maintenance to ensure that your users are provided with an excellent experience, no matter what type of device they use.
""",
      JWService.firebase => """
Harnessing the power of Google Firebase, serve your mobile apps with the internet capabilities they require with ease.

Create backend functionality that works for all platforms, provides a high degree of security, and easily scales to suit the size of your user base.
""",
    };
  }

  String _skillsForService(JWService service) {
    return switch (service) {
      JWService.ios =>
        "Swift, SwiftUI, UIKit, Combine, Objective-C(++), AVFoundation, Bluetooth LE, Photos, Firebase, Alamofire, CoreData...",
      JWService.flutter =>
        "Dart, BLoC, Riverpod, Method Channels, Firebase, http...",
      JWService.firebase =>
        "Firestore, Cloud Functions, Cloud Messaging, Analytics, Cloud Storage...",
    };
  }

  String _imageAssetForService(JWService service) {
    return switch (service) {
      JWService.ios => "ios.png",
      JWService.flutter => "flutter.png",
      JWService.firebase => "firebase.png",
    };
  }
}
