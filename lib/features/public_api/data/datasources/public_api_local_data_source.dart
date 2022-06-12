import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/features/public_api/data/models/public_api_model.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:dartz/dartz.dart';

abstract class PublicApiLocalDataSource {
  Future<PublicApiModel> getLastPublicApi();
  Future<void> cachePublicApi(PublicApiModel publicApiToCache);
}