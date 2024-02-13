import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Row(
          children: [
            Text(
              tr(LocaleKeys.copyright),
              style: CustomTextStyles.paragraph3(),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => LaunchableUrls.websiteRepository.launch(),
              child: Text(
                tr(LocaleKeys.viewSourceCode),
                style: CustomTextStyles.paragraph3(
                  color: CustomColors.secondaryColor.l2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
