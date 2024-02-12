import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_item_info_view_model.freezed.dart';
part 'portfolio_item_info_view_model.g.dart';

@freezed
class PortfolioItemInfoState with _$PortfolioItemInfoState {
  factory PortfolioItemInfoState({
    required List<PortfolioItemInfoPage> pages,
    required int currentPageIndex,
  }) = _PortfolioItemInfoState;
}

@riverpod
class PortfolioItemInfoViewModel extends _$PortfolioItemInfoViewModel {
  @override
  PortfolioItemInfoState build(PortfolioItemModel portfolioItemModel) {
    return PortfolioItemInfoState(
      pages: portfolioItemModel.infoPages,
      currentPageIndex: 0,
    );
  }

  void selectNextPage() {
    int nextPageIndex = state.currentPageIndex + 1;
    nextPageIndex = nextPageIndex < state.pages.length ? nextPageIndex : 0;
    state = state.copyWith(currentPageIndex: nextPageIndex);
  }

  void selectPreviousPage() {
    int nextPageIndex = state.currentPageIndex - 1;
    nextPageIndex = nextPageIndex >= 0 ? nextPageIndex : state.pages.length - 1;
    state = state.copyWith(currentPageIndex: nextPageIndex);
  }
}
