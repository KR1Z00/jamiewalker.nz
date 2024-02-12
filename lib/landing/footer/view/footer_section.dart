import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
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
              "Copyright © Jamie Walker 2024",
              style: CustomTextStyles.paragraph3(),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => LaunchableUrls.websiteRepository.launch(),
              child: Text(
                "See the source code for this website!",
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
