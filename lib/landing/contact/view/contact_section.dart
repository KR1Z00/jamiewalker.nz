import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/constants/launchable_urls.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/landing/contact/domain/contact_view_model.dart';

class ContactSection extends ConsumerWidget {
  static const double minHeight = 800;

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
    final height = max(minHeight, screenHeight * 0.65);

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

    final guidanceTextStyle = context.layoutForMobile()
        ? CustomTextStyles.paragraph3
        : CustomTextStyles.paragraph2;
    final double paddingBetweenElements =
        context.layoutForMobile() ? 30 : ScreenSize.minimumPadding.toDouble();

    return context.wrappedForHorizontalPosition(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 700,
            minHeight: height,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: paddingBetweenElements,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tr(LocaleKeys.contactSectionTitleAlt),
                    style: CustomTextStyles.header2(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              Text(
                tr(LocaleKeys.contactPrompt),
                style: guidanceTextStyle(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: paddingBetweenElements,
                ),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      tr(LocaleKeys.contactDirectEmailGuidance),
                      style: guidanceTextStyle(),
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
                        style: guidanceTextStyle(
                          color: CustomColors.secondaryColor.l2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(LocaleKeys.contactFormName),
                    style: guidanceTextStyle(
                      fontStyle: FontStyle.italic,
                    ),
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
                    style: guidanceTextStyle(
                      fontStyle: FontStyle.italic,
                    ),
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
                    style: guidanceTextStyle(
                      fontStyle: FontStyle.italic,
                    ),
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
            ],
          ),
        ),
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
              color: CustomColors.primaryColor.l2,
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
                      style: CustomTextStyles.header3(
                        color: CustomColors.primaryColor.d1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        description,
                        style: CustomTextStyles.paragraph2(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (showProgressIndicator)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
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
                          LocaleKeys.contactSendingDismiss,
                          style: CustomTextStyles.header4(
                            color: CustomColors.primaryColor.d1,
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
