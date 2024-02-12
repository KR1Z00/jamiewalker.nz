import 'package:cloud_functions/cloud_functions.dart';
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

    try {
      await FirebaseFunctions.instance.httpsCallable("sendMessage").call({
        "name": name,
        "email": email,
        "message": message,
      });
      state = ContactViewModelState.successfullySent;
    } catch (exception) {
      state = ContactViewModelState.error;
    }
  }

  void dismissResult() {
    state = ContactViewModelState.idle;
  }
}
