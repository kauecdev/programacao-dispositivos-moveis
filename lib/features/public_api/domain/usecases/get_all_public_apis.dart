import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:clean_app_flutter/features/public_api/domain/repositories/public_api_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPublicApis {
  final PublicApiRepository repository;

  GetAllPublicApis(this.repository);

  Future<Either<Failure, List<PublicApi>>> execute() async {
    return await repository.getAllPublicApis();
  }
}