import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';

class PublicApiModel extends PublicApi {
  PublicApiModel({
    required String apiName,
    required String description,
    required String category,
    required String link,
    required bool isHttps})
      : super(apiName: apiName, description: description, category: category, link: link, isHttps: isHttps);

  factory PublicApiModel.fromJson(Map<String, dynamic> json) {
    return PublicApiModel(
      apiName: json['API'],
      description: json['Description'],
      category: json['Category'],
      link: json['Link'],
      isHttps: json['HTTPS']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API' : apiName,
      'Description': description,
      'Category' : category,
      'Link' : link,
      'HTTPS': isHttps
    };
  }
}