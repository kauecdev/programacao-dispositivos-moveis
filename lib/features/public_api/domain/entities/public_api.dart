import 'package:equatable/equatable.dart';

class PublicApi extends Equatable {
  final String apiName;
  final String description;
  final String category;
  final String link;
  final bool isHttps;

  PublicApi({
    required this.apiName,
    required this.description,
    required this.category,
    required this.link,
    required this.isHttps,
  });

  @override
  List<Object?> get props => [
    apiName,
    description,
    category,
    link,
    isHttps,
  ];

}