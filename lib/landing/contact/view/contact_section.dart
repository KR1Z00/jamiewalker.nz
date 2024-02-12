import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';

class ContactSection extends StatelessWidget {
  final TextEditingController nameTextEditingController;
  final TextEditingController emailTextEditingController;
  final TextEditingController messageTextEditingController;

  const ContactSection({
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.messageTextEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr(LocaleKeys.contactSectionTitleAlt),
                  style: CustomTextStyles.header2(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Ready to bring your mobile app needs to life? Get in contact below to get the ball rolling. I look forward to delivering a solution for you.",
                  style: CustomTextStyles.paragraph2(),
                  // textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: CustomTextStyles.paragraph2(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: CustomTextStyles.paragraph2(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: CustomTextStyles.paragraph2(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: messageTextEditingController,
                      maxLines: 7,
                    ),
                  ],
                ),
                Center(
                  child: PrimaryTextButton(
                    onPressed: () {},
                    title: "Send",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
