import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/localization/locale_controller.dart';
import 'package:jamie_walker_website/landing/testimonials/data/testimonial_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'testimonials_repository.g.dart';

@riverpod
class TestimonialsRepository extends _$TestimonialsRepository {
  @override
  List<TestimonialModel> build() {
    final locale = ref.watch(localeControllerProvider);
    final testimonialsJson = trList(locale, LocaleKeys.testimonials);
    return testimonialsJson
        .map((json) => TestimonialModel.fromJson(json))
        .toList();
  }
}
