import 'package:url_launcher/url_launcher_string.dart';

enum LaunchableUrls {
  github("https://www.github.com/KR1Z00"),
  linkedIn("https://www.linkedin.com/in/jamie-walker-a3593615a/"),
  emailMe("mailto:jamie@jamiewalker.nz"),
  websiteRepository("https://github.com/KR1Z00/jamiewalker.nz"),
  ;

  final String url;

  const LaunchableUrls(this.url);

  void launch() {
    launchUrlString(url);
  }
}
