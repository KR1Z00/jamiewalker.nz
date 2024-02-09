import 'package:flutter/widgets.dart';
import 'package:jamie_walker_website/app/localization/app_locales.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_controller.g.dart';

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    return AppLocales.fallbackLocale;
  }
}
