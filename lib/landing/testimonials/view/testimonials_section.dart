import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
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
          final int commentMaxLines = context.layoutForMobile() ? 12 : 5;
          final double imageSize = context.layoutForMobile() ? 200 : 300;
          final double commentHeight = context.layoutForMobile() ? 200 : 100;

          return Column(
            children: [
              const SizedBox(
                height: JamieWalkerAppBar.preferredHeight,
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenSize.minimumPadding.toDouble(),
                  bottom: 20,
                ),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tr(LocaleKeys.testimonialsSectionTitleAlt),
                              style: context
                                  .appTextStyles()
                                  .sectionHeaderTextStyle(context),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ),
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
                                    color: context.colorScheme().secondary,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: imageSize,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Opacity(
                                      opacity: animationController.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            StandardBoxShadows.regular(),
                                          ],
                                          border: Border.all(
                                            color:
                                                context.colorScheme().secondary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            imageSize / 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            imageSize,
                                          ),
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
                                  icon: FaIcon(FontAwesomeIcons.chevronRight,
                                      color: context.colorScheme().secondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Opacity(
                            opacity: animationController.value,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                testimonial.name,
                                style: context
                                    .appTextStyles()
                                    .bodyTextStyle(context),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(height: commentHeight),
                          child: Opacity(
                            opacity: animationController.value,
                            child: AutoSizeText(
                              "\"${testimonial.comment}\"",
                              style: context
                                  .appTextStyles()
                                  .bodyTextStyle(context),
                              textAlign: TextAlign.left,
                              minFontSize: 10,
                              maxLines: commentMaxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: _state.currentTestimonialIndex,
                              count: _state.totalTestimonialsCount,
                              effect: WormEffect(
                                dotWidth: 8,
                                dotHeight: 8,
                                dotColor: context
                                    .colorScheme()
                                    .secondary
                                    .withOpacity(0.3),
                                activeDotColor: context.colorScheme().secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
