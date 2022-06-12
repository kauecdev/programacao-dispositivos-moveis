import 'package:clean_app_flutter/features/public_api/data/models/public_api_model.dart';
import 'package:dartz/dartz.dart';

abstract class PublicApiRemoteDataSource {
  Future<PublicApiModel> getRandomPublicApi();
  Future<List<PublicApiModel>> getAllPublicApis();
}

class PublicApiRemoteDataSourceImpl extends PublicApiRemoteDataSource {
  @override
  Future<List<PublicApiModel>> getAllPublicApis() {
    final mockedPublicApiList = List.of([PublicApiModel(apiName: "test", description: "test", category: "test", link: "test", isHttps: true)]);
    return Future(() => mockedPublicApiList);
  }

  @override
  Future<PublicApiModel> getRandomPublicApi() {
    final mockedPublicApi = PublicApiModel(apiName: "test", description: "test", category: "test", link: "test", isHttps: true);
    return Future(() => mockedPublicApi);
  }

}