import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_item_model.freezed.dart';
part 'portfolio_item_model.g.dart';

@freezed
class PortfolioItemModel with _$PortfolioItemModel {
  factory PortfolioItemModel({
    required String itemId,
    required String name,
    required String previewImageAsset,
    required String previewDescription,
    required String technologiesUsed,
    String? appStoreUrl,
    required List<PortfolioItemInfoPage> infoPages,
  }) = _PortfolioItemModel;

  factory PortfolioItemModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioItemModelFromJson(json);
}

@freezed
class PortfolioItemInfoPage with _$PortfolioItemInfoPage {
  factory PortfolioItemInfoPage({
    required PortfolioItemInfoPageContentType contentType,
    String? imageAsset,
    String? youtubeVideoId,
    required String description,
  }) = _PortfolioItemInfoPage;

  factory PortfolioItemInfoPage.fromJson(Map<String, dynamic> json) =>
      _$PortfolioItemInfoPageFromJson(json);
}

@JsonEnum()
enum PortfolioItemInfoPageContentType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
}
