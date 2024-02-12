import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';
import 'package:jamie_walker_website/generic/view/primary_text_button.dart';
import 'package:jamie_walker_website/landing/contact/domain/contact_view_model.dart';

class ContactSection extends ConsumerWidget {
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

    return context.wrappedForHorizontalPosition(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.minimumPadding.toDouble(),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr(LocaleKeys.contactSectionTitleAlt),
                  style: CustomTextStyles.header2(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Ready to bring your mobile app needs to life? Get in contact below to get the ball rolling. I look forward to delivering a solution for you.",
                  style: CustomTextStyles.paragraph2(),
                  // textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: CustomTextStyles.paragraph2(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: CustomTextStyles.paragraph2(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: CustomTextStyles.paragraph2(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: messageTextEditingController,
                      maxLines: 7,
                    ),
                  ],
                ),
                Center(
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
                    title: "Send",
                  ),
                ),
              ],
            ),
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
                          "Done",
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
      ContactViewModelState.sending => "Sending",
      ContactViewModelState.successfullySent => "Thanks!",
      ContactViewModelState.error => "Oops!",
    };
  }

  String? _descriptionForContactViewModelState(ContactViewModelState state) {
    return switch (state) {
      ContactViewModelState.idle => null,
      ContactViewModelState.sending => null,
      ContactViewModelState.successfullySent =>
        "Your message has been sent. I'll get back to you within 2 business days.",
      ContactViewModelState.error =>
        "An error occurred trying to send your message, please try again.",
    };
  }
}
