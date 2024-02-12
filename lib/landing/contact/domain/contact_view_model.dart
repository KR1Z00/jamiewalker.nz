import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_view_model.g.dart';

enum ContactViewModelState {
  idle,
  sending,
  successfullySent,
  error,
}

@Riverpod(keepAlive: true)
class ContactViewModel extends _$ContactViewModel {
  @override
  ContactViewModelState build() {
    return ContactViewModelState.idle;
  }

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    state = ContactViewModelState.sending;

    await Future.delayed(const Duration(seconds: 1));

    state = ContactViewModelState.successfullySent;
  }

  void dismissResult() {
    state = ContactViewModelState.idle;
  }
}
