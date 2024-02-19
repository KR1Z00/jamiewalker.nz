import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 40,
          runSpacing: 10,
          children: [
            Text(
              tr(LocaleKeys.copyright),
              style: context.textTheme().bodyMedium,
            ),
            TextButton(
              onPressed: () => LaunchableUrls.websiteRepository.launch(),
              child: Text(
                tr(LocaleKeys.viewSourceCode),
                style: context.textTheme().bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
