import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'package:jamie_walker_website/generic/view/jamie_walker_app_bar.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/landing/contact/domain/contact_view_model.dart';

class ContactSection extends ConsumerWidget {
  static const double minHeight = 720;

  final TextEditingController nameTextEditingController;
  final TextEditingController emailTextEditingController;
  final TextEditingController messageTextEditingController;

  const ContactSection({
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.messageTextEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final height = max(minHeight, screenHeight);
    print(screenHeight);

    ref.listen(
      contactViewModelProvider,
      (previous, next) {
        final shouldShowDialog = _showDialogFor(next);
        final isDialogShown = ModalRoute.of(context)?.isCurrent != true;
        if (shouldShowDialog && !isDialogShown) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const _ContactSendingDialog(),
          );
        } else if (!shouldShowDialog && isDialogShown) {
          context.pop();
        }
      },
    );

    final double paddingBetweenElements =
        context.layoutForMobile() ? 30 : ScreenSize.minimumPadding.toDouble();

    return context.wrappedForHorizontalPosition(
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
                tr(LocaleKeys.contactSectionTitleAlt),
                style: context.appTextStyles().sectionHeaderTextStyle(context),
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
                    tr(LocaleKeys.contactPrompt),
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
                        controller: nameTextEditingController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: paddingBetweenElements,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(LocaleKeys.contactFormEmail),
                        style: context.textTheme().labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailTextEditingController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: paddingBetweenElements,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(LocaleKeys.contactFormMessage),
                        style: context.textTheme().labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: messageTextEditingController,
                        maxLines: null,
                      ),
                    ],
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
                                contactViewModelProvider.notifier,
                              )
                              .sendMessage(
                                name: nameTextEditingController.text,
                                email: emailTextEditingController.text,
                                message: messageTextEditingController.text,
                              );
                        },
                        title: tr(LocaleKeys.contactSend),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: paddingBetweenElements,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          tr(LocaleKeys.contactDirectEmailGuidance),
                          style: context.appTextStyles().bodyTextStyle(context),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        TextButton(
                          onPressed: () => LaunchableUrls.emailMe.launch(),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Text(
                            tr(LocaleKeys.contactEmail),
                            style:
                                context.appTextStyles().bodyTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _showDialogFor(ContactViewModelState state) {
    return state != ContactViewModelState.idle;
  }
}

class _ContactSendingDialog extends ConsumerStatefulWidget {
  const _ContactSendingDialog();

  @override
  ConsumerState createState() => __ContactSendingDialogState();
}

class __ContactSendingDialogState extends ConsumerState<_ContactSendingDialog> {
  late ContactViewModelState _state;

  @override
  void initState() {
    _state = ref.read(contactViewModelProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(contactViewModelProvider, (previous, next) {
      if (next != ContactViewModelState.idle) {
        setState(() {
          _state = next;
        });
      }
    });

    final title = _titleForContactViewModelState(_state);
    final description = _descriptionForContactViewModelState(_state);
    final showDismissButton = [
      ContactViewModelState.successfullySent,
      ContactViewModelState.error,
    ].contains(_state);
    final showProgressIndicator = _state == ContactViewModelState.sending;

    return context.wrappedForHorizontalPosition(
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
                              .read(contactViewModelProvider.notifier)
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

  String? _titleForContactViewModelState(ContactViewModelState state) {
    return switch (state) {
      ContactViewModelState.idle => null,
      ContactViewModelState.sending => tr(
          LocaleKeys.contactSending,
        ),
      ContactViewModelState.successfullySent => tr(
          LocaleKeys.contactSentSuccessTitle,
        ),
      ContactViewModelState.error => tr(
          LocaleKeys.contactSendingFailedTitle,
        ),
    };
  }

  String? _descriptionForContactViewModelState(ContactViewModelState state) {
    return switch (state) {
      ContactViewModelState.idle => null,
      ContactViewModelState.sending => null,
      ContactViewModelState.successfullySent => tr(
          LocaleKeys.contactSentSuccessDescription,
        ),
      ContactViewModelState.error => tr(
          LocaleKeys.contactSendingFailedDescription,
        ),
    };
  }
}
