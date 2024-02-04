import 'dart:ui';

import 'generated/locale_json.g.dart';

List<Map<String, dynamic>> trList(Locale locale, String key) {
  final mapLocales = CodegenLoader.mapLocales[locale.languageCode];
  final mapValue = mapLocales?[key];
  return mapValue;
}
