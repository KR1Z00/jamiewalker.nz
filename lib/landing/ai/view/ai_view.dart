import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/landing/ai/domain/ai_view_model.dart';

import '../../../app/extensions/screen_size.dart';
import '../../../app/localization/generated/locale_keys.g.dart';
import '../../../generic/view/jamie_walker_app_bar.dart';
import '../../../generic/view/primary_text_button.dart';
import '../../../generic/view/standard_horizontal_padding.dart';

class AISection extends ConsumerWidget {
  static const double minHeight = 720;

  final TextEditingController aiPromptController;

  const AISection({
    required this.aiPromptController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final height = max(minHeight, screenHeight * (4 / 5));

    ref.listen(
      aIViewModelProvider,
      (previous, next) {
        final shouldShowDialog = _showDialogFor(next);
        final isDialogShown = ModalRoute.of(context)?.isCurrent != true;
        if (shouldShowDialog && !isDialogShown) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const _AISendingDialog(),
          );
        } else if (!shouldShowDialog && isDialogShown) {
          context.pop();
        }
      },
    );

    final double paddingBetweenElements =
        context.layoutForMobile() ? 30 : ScreenSize.minimumPadding.toDouble();

    return StandardHorizontalPadding(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: JamieWalkerAppBar.preferredHeight,
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.minimumPadding.toDouble(),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  tr(LocaleKeys.aiSectionTitle),
                  style:
                      context.appTextStyles().sectionHeaderTextStyle(context),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      tr(LocaleKeys.aiPrompt),
                      style: context.appTextStyles().bodyTextStyle(context),
                    ),
                    SizedBox(
                      height: paddingBetweenElements,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(LocaleKeys.contactFormName),
                          style: context.textTheme().labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: aiPromptController,
                          style: context.appTextStyles().bodyTextStyle(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: paddingBetweenElements,
                          ),
                          child: Center(
                            child: PrimaryTextButton(
                              onPressed: () {
                                ref
                                    .read(
                                      aIViewModelProvider.notifier,
                                    )
                                    .generateWorkout(
                                      textToSpeechWorkoutQuote:
                                          aiPromptController.text,
                                    );
                              },
                              title: tr(LocaleKeys.contactSend),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _showDialogFor(AIViewModelState state) {
    return state.status != AIViewModelStatus.idle;
  }
}

class _AISendingDialog extends ConsumerStatefulWidget {
  const _AISendingDialog();

  @override
  ConsumerState createState() => __AISendingDialogState();
}

class __AISendingDialogState extends ConsumerState<_AISendingDialog> {
  late AIViewModelState _state;

  @override
  void initState() {
    _state = ref.read(aIViewModelProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(aIViewModelProvider, (previous, next) {
      if (next.status != AIViewModelStatus.idle) {
        setState(() {
          _state = next;
        });
      }
    });

    final title = _titleForAIViewModelState(_state.status);
    final description = _descriptionForAIViewModelState(
      _state.status,
      _state.result,
    );

    final showDismissButton = [
      AIViewModelStatus.success,
      AIViewModelStatus.error,
    ].contains(_state.status);

    final showProgressIndicator = _state.status == AIViewModelStatus.sending;

    return StandardHorizontalPadding(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: context.layoutForMobile() ? 0.8 : 0.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colorScheme().primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ScreenSize.minimumPadding.toDouble(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title,
                      style: context.textTheme().displaySmall?.copyWith(
                            color: context.colorScheme().onPrimaryContainer,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        description,
                        style: context
                            .appTextStyles()
                            .bodyTextStyle(context)
                            .copyWith(
                              color: context.colorScheme().onPrimaryContainer,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (showProgressIndicator)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        color: context.colorScheme().onPrimaryContainer,
                      ),
                    ),
                  if (showDismissButton)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {
                          ref
                              .read(aIViewModelProvider.notifier)
                              .dismissResult();
                        },
                        child: Text(
                          tr(LocaleKeys.contactSendingDismiss),
                          style: context.textTheme().labelMedium?.copyWith(
                                color: context.colorScheme().onPrimaryContainer,
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _titleForAIViewModelState(AIViewModelStatus state) {
    return switch (state) {
      AIViewModelStatus.idle => null,
      AIViewModelStatus.sending => tr(LocaleKeys.aiGenerating),
      AIViewModelStatus.success => tr(LocaleKeys.aiSuccessTitle),
      AIViewModelStatus.error => tr(LocaleKeys.aiErrorTitle),
    };
  }

  String? _descriptionForAIViewModelState(
    AIViewModelStatus state,
    String? result,
  ) {
    return switch (state) {
      AIViewModelStatus.idle => null,
      AIViewModelStatus.sending => null,
      AIViewModelStatus.success => result,
      AIViewModelStatus.error => tr(LocaleKeys.aiErrorDescription),
    };
  }
}
