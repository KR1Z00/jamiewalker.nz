import 'package:jamie_walker_website/app/localization/generated/locale_keys.g.dart';
import 'package:jamie_walker_website/app/localization/json_list_translation.dart';
import 'package:jamie_walker_website/app/localization/locale_controller.dart';
import 'package:jamie_walker_website/landing/portfolio/data/portfolio_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_repository.g.dart';

@Riverpod(keepAlive: true)
class PortfolioRepository extends _$PortfolioRepository {
  @override
  Future<List<PortfolioItemModel>> build() async {
    final locale = ref.watch(localeControllerProvider);
    final testimonialsJson = trList(locale, LocaleKeys.portfolioItems);
    return testimonialsJson
        .map((json) => PortfolioItemModel.fromJson(json))
        .toList();
  }
}
