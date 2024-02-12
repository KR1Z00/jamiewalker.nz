import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/landing/testimonials/domain/testimonials_section_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TestimonialsSection extends StatefulHookConsumerWidget {
  const TestimonialsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TestimonialsSectionState();
}

class _TestimonialsSectionState extends ConsumerState<TestimonialsSection> {
  final _changeAnimationDuration = const Duration(milliseconds: 200);
  late TestimonialsSectionState _state;

  @override
  Widget build(BuildContext context) {
    // Instead of using ref.watch, we use a StatefulWidget plus a combination
    // of ref.read and ref.listen.
    //
    // This is so we can do a fade in and out animation while we change the
    // state to the next testimonial.
    //
    // If we were just to use ref.watch, the state change would occur before
    // the fade out, making it jump instead of smoothly fade, rendering the
    // animation pointless.
    _state = ref.read(testimonialsSectionViewModelProvider);
    final testimonial = _state.currentTestimonial;
    final animationController = useAnimationController(
      duration: _changeAnimationDuration,
      initialValue: 1,
    );

    ref.listen(
      testimonialsSectionViewModelProvider,
      (previous, next) {
        animationController.animateBack(0).then((value) {
          setState(() {
            _state = ref.read(testimonialsSectionViewModelProvider);
          });
          animationController.animateTo(1);
        });
      },
    );

    return context.wrappedForHorizontalPosition(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenSize.minimumPadding.toDouble(),
            ),
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          tr(LocaleKeys.testimonialsSectionTitleAlt),
                          style: context.themeData().textTheme.displayMedium,
                          maxLines: 1,
                          minFontSize: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: ScreenSize.minimumPadding.toDouble(),
                                ),
                                child: IconButton(
                                  onPressed: ref
                                      .read(testimonialsSectionViewModelProvider
                                          .notifier)
                                      .selectPreviousTestimonial,
                                  icon: FaIcon(
                                    FontAwesomeIcons.chevronLeft,
                                    color:
                                        context.themeData().colorScheme.primary,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Opacity(
                                      opacity: animationController.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: context
                                                .themeData()
                                                .colorScheme
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: Image.asset(
                                            testimonial.imageAsset,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenSize.minimumPadding.toDouble(),
                                ),
                                child: IconButton(
                                  onPressed: ref
                                      .read(testimonialsSectionViewModelProvider
                                          .notifier)
                                      .selectNextTestimonial,
                                  icon: FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    color:
                                        context.themeData().colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Opacity(
                            opacity: animationController.value,
                            child: Text(
                              testimonial.name,
                              style: context.themeData().textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(height: 100),
                          child: Opacity(
                            opacity: animationController.value,
                            child: AutoSizeText(
                              "\"${testimonial.comment}\"",
                              style: context
                                  .themeData()
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              textAlign: TextAlign.center,
                              minFontSize: 14,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: AnimatedSmoothIndicator(
                            activeIndex: _state.currentTestimonialIndex,
                            count: _state.totalTestimonialsCount,
                            effect: WormEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              dotColor: context
                                  .themeData()
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                              activeDotColor:
                                  context.themeData().colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
