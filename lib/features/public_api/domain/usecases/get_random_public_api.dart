import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/core/usecases/usecase.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:clean_app_flutter/features/public_api/domain/repositories/public_api_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomPublicApi extends UseCase<PublicApi, NoParams>{
  final PublicApiRepository repository;

  GetRandomPublicApi(this.repository);

  @override
  Future<Either<Failure, PublicApi>> call(NoParams params) async {
    return await repository.getRandomPublicApi();
  }
}