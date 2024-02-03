part of '../../view/landing_page.dart';

class _TestimonialsSection extends StatefulHookConsumerWidget {
  const _TestimonialsSection();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __TestimonialsSectionState();
}

class __TestimonialsSectionState extends ConsumerState<_TestimonialsSection> {
  final _changeAnimationDuration = const Duration(milliseconds: 200);
  late TestimonialsSectionState _state;

  @override
  Widget build(BuildContext context) {
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
                          style: CustomTextStyles.header2(),
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
                                    color: CustomColors.secondaryColor.l1,
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
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 10,
                                            ),
                                          ],
                                          border: Border.all(
                                            color:
                                                CustomColors.secondaryColor.l1,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: Image.network(
                                            testimonial.refereeImageUri,
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
                                    color: CustomColors.secondaryColor.l1,
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
                              testimonial.refereeName,
                              style: CustomTextStyles.paragraph1(),
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
                              style: CustomTextStyles.paragraph2(
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
                              dotColor: CustomColors.secondaryColor.l1
                                  .withOpacity(0.3),
                              activeDotColor: CustomColors.secondaryColor.l1,
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
