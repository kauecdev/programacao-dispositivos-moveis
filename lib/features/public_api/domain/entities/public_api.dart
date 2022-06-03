import 'package:equatable/equatable.dart';

class PublicApi extends Equatable {
  final String API;
  final String description;
  final String category;
  final String link;
  final bool https;

  PublicApi({
    required this.API,
    required this.description,
    required this.category,
    required this.link,
    required this.https,
  });

  @override
  List<Object?> get props {
    throw UnimplementedError();
  }

}