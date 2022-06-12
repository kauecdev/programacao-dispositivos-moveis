import 'package:clean_app_flutter/core/error/exceptions.dart';
import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/features/public_api/data/datasources/public_api_local_data_source.dart';
import 'package:clean_app_flutter/features/public_api/data/datasources/public_api_remote_data_source.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:clean_app_flutter/features/public_api/domain/repositories/public_api_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../models/public_api_model.dart';

class PublicApiRepositoryImpl implements PublicApiRepository {
  final PublicApiRemoteDataSource remoteDataSource;
  final PublicApiLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PublicApiRepositoryImpl({
      required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo
  });

  @override
  Future<Either<Failure, List<PublicApi>>> getAllPublicApis() async {
    networkInfo.isConnected;
    return Right(await remoteDataSource.getAllPublicApis());
  }

  @override
  Future<Either<Failure, PublicApi>> getRandomPublicApi() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePublicApi = await remoteDataSource.getRandomPublicApi();
        localDataSource.cachePublicApi(remotePublicApi);
        return Right(remotePublicApi);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPublicApi = await localDataSource.getLastPublicApi();
        return Right(localPublicApi);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}