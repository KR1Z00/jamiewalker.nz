import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Text(
          tr(LocaleKeys.portfolioSectionTitleAlt),
          style: CustomTextStyles.header2(),
        ),
      ),
    );
  }

  Future<String> _loadImage() async {
    final imageRef = FirebaseStorage.instance.ref('image.jpg');
    return imageRef.getDownloadURL();
  }
}
