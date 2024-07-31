import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_view_model.g.dart';

enum AIViewModelStatus {
  idle,
  sending,
  success,
  error,
}

class AIViewModelState {
  final AIViewModelStatus status;
  final String? result;

  const AIViewModelState({
    required this.status,
    this.result,
  });
}

@Riverpod(keepAlive: true)
class AIViewModel extends _$AIViewModel {
  @override
  AIViewModelState build() {
    return const AIViewModelState(
      status: AIViewModelStatus.idle,
    );
  }

  Future<void> generateWorkout({
    required String textToSpeechWorkoutQuote,
  }) async {
    state = const AIViewModelState(
      status: AIViewModelStatus.sending,
    );

    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable("generateWorkout")
          .call(
            textToSpeechWorkoutQuote,
          );

      final Map data = result.data;

      state = AIViewModelState(
        status: AIViewModelStatus.success,
        result: data.toString(),
      );
    } catch (exception) {
      state = const AIViewModelState(
        status: AIViewModelStatus.error,
      );
    }
  }

  void dismissResult() {
    state = const AIViewModelState(
      status: AIViewModelStatus.idle,
    );
  }
}
