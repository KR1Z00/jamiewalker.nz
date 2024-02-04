import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jamie_walker_website/landing/testimonials/data/testimonial_model.dart';
import 'package:jamie_walker_website/landing/testimonials/data/testimonials_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'testimonials_section_view_model.g.dart';
part 'testimonials_section_view_model.freezed.dart';

@freezed
class TestimonialsSectionState with _$TestimonialsSectionState {
  const factory TestimonialsSectionState({
    required TestimonialModel currentTestimonial,
    required int currentTestimonialIndex,
    required int totalTestimonialsCount,
  }) = _TestimonialsSectionState;
}

@riverpod
class TestimonialsSectionViewModel extends _$TestimonialsSectionViewModel {
  static const Duration _autoCycleDuration = Duration(seconds: 7);

  int _currentTestimonialIndex = 0;
  late int _numberOfTestimonials;

  // Used to automatically cycle through the testimonials
  Timer? _autoCycleTimer;

  @override
  TestimonialsSectionState build() {
    final testimonials = ref.read(testimonialsRepositoryProvider);
    _numberOfTestimonials = testimonials.length;
    final currentTestimonial = testimonials[_currentTestimonialIndex];

    if (_autoCycleTimer == null) {
      _restartAutoCycleTimer();
    }

    return TestimonialsSectionState(
      currentTestimonial: currentTestimonial,
      currentTestimonialIndex: _currentTestimonialIndex,
      totalTestimonialsCount: _numberOfTestimonials,
    );
  }

  void selectNextTestimonial() {
    final nextIndex = _currentTestimonialIndex + 1;
    _currentTestimonialIndex =
        nextIndex >= _numberOfTestimonials ? 0 : nextIndex;
    state = build();
    _restartAutoCycleTimer();
  }

  void selectPreviousTestimonial() {
    final nextIndex = _currentTestimonialIndex - 1;
    _currentTestimonialIndex =
        nextIndex < 0 ? _numberOfTestimonials - 1 : nextIndex;
    state = build();
    _restartAutoCycleTimer();
  }

  void _restartAutoCycleTimer() {
    _autoCycleTimer?.cancel();
    _autoCycleTimer = Timer.periodic(
      _autoCycleDuration,
      (timer) => selectNextTestimonial(),
    );
  }
}
