import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

class ContactSection extends StatelessWidget {
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _messageTextEditingController = TextEditingController();

  ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                tr(LocaleKeys.contactSectionTitleAlt),
                style: context.themeData().textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Text(
                "Ready to bring your mobile app needs to life? Get in contact below to get the ball rolling. I look forward to delivering a solution for you.",
                style: context.themeData().textTheme.bodyMedium,
                // textAlign: TextAlign.center,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: CustomColors.primaryColor.d1,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Name",
                      style: context.themeData().textTheme.bodySmall,
                    ),
                    TextField(
                      controller: _nameTextEditingController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Email",
                      style: context.themeData().textTheme.bodySmall,
                    ),
                    TextField(
                      controller: _emailTextEditingController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Message",
                      style: context.themeData().textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 100,
                      child: TextField(
                        controller: _messageTextEditingController,
                        expands: true,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
