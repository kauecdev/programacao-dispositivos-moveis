import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:dartz/dartz.dart';

abstract class PublicApiRepository {
  Future<Either<Failure, PublicApi>> getRandomPublicApi();
  Future<Either<Failure, List<PublicApi>>> getAllPublicApis();
}