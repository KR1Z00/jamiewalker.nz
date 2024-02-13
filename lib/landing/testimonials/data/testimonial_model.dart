import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonial_model.freezed.dart';
part 'testimonial_model.g.dart';

/// A model of a Testimonial to be shown in the portfolio
///
/// Contains information about the referee that provided the testimonial, as
/// well as their comment
@freezed
class TestimonialModel with _$TestimonialModel {
  factory TestimonialModel({
    required String name,
    required String imageAsset,
    required String comment,
  }) = _TestimonialModel;

  factory TestimonialModel.fromJson(Map<String, dynamic> json) =>
      _$TestimonialModelFromJson(json);
}
