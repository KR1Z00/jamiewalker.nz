import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonial_model.freezed.dart';
part 'testimonial_model.g.dart';

@freezed
class TestimonialModel with _$TestimonialModel {
  factory TestimonialModel({
    required String refereeName,
    required String refereeImageUri,
    required String comment,
  }) = _TestimonialModel;

  factory TestimonialModel.fromJson(Map<String, dynamic> json) =>
      _$TestimonialModelFromJson(json);
}
