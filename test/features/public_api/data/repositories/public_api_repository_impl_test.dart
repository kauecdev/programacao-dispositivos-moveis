import 'dart:math';

import 'package:clean_app_flutter/core/error/exceptions.dart';
import 'package:clean_app_flutter/core/error/failure.dart';
import 'package:clean_app_flutter/core/network/network_info.dart';
import 'package:clean_app_flutter/features/public_api/data/datasources/public_api_local_data_source.dart';
import 'package:clean_app_flutter/features/public_api/data/datasources/public_api_remote_data_source.dart';
import 'package:clean_app_flutter/features/public_api/data/models/public_api_model.dart';
import 'package:clean_app_flutter/features/public_api/data/repositories/public_api_repository_impl.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements PublicApiRemoteDataSource {}

class MockLocalDataSource extends Mock implements PublicApiLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource = MockRemoteDataSource();
  MockLocalDataSource mockLocalDataSource = MockLocalDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  PublicApiRepositoryImpl repository = PublicApiRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => true);
        body();
      });
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => false);
        body();
      });
    });
  }


  group('getAllPublicApis', () {
    final publicApiModelTest = PublicApiModel(apiName: "CoinCap", description: "Real time Cryptocurrency prices through a RESTful API", category: "Cryptocurrency", link: "https://docs.coincap.io/", isHttps: true);
    final PublicApi publicApiTest = publicApiModelTest;

    test(
      'should check if device is online',
        () async {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => true);

          repository.getAllPublicApis();

          verify(() => mockNetworkInfo.isConnected);
        }
    );

    runTestsOnline(() {

      test(
        'should return remote data when the call to remote source is successful',
        () async {
          when(() => mockRemoteDataSource.getAllPublicApis())
              .thenAnswer((_) async => Future(() => List.of([publicApiModelTest])));

          final result = await repository.getAllPublicApis();

          verify(() => mockRemoteDataSource.getAllPublicApis());
          expect(result, equals(Right(List.of([publicApiTest]))));
        }
      );

      test(
          'should cache the data locally when the call to remote source is successful',
              () async {
            when(() => mockRemoteDataSource.getAllPublicApis())
                .thenAnswer((_) async => Future(() => List.of([publicApiModelTest])));

            await repository.getAllPublicApis();

            verify(() => mockRemoteDataSource.getAllPublicApis());
            verify(() => mockLocalDataSource.cachePublicApi(publicApiModelTest));
          }
      );
    });


    runTestsOffline(() {
    });
  });

  group('getRandomPublicApi', () {
    final publicApiModelTest = PublicApiModel(apiName: "CoinCap", description: "Real time Cryptocurrency prices through a RESTful API", category: "Cryptocurrency", link: "https://docs.coincap.io/", isHttps: true);
    final PublicApi publicApiTest = publicApiModelTest;

    test(
        'should check if device is online',
            () async {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => true);

          repository.getRandomPublicApi();

          verify(() => mockNetworkInfo.isConnected);
        }
    );

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote source is successful',
              () async {
            when(() => mockRemoteDataSource.getRandomPublicApi())
                .thenAnswer((_) async => Future(() => publicApiModelTest));

            final result = await repository.getRandomPublicApi();

            verify(() => mockRemoteDataSource.getRandomPublicApi());
            expect(result, equals(Right(publicApiTest)));
          }
      );

      test(
          'should cache the data locally when the call to remote source is successful',
              () async {
            when(() => mockRemoteDataSource.getRandomPublicApi())
                .thenAnswer((_) => Future(() => publicApiModelTest));

            await repository.getRandomPublicApi();

            verify(() => mockRemoteDataSource.getRandomPublicApi());
            verify(() => mockLocalDataSource.cachePublicApi(publicApiModelTest));
          }
      );

      test(
          'should return server failure when the call to remote source is successful',
              () async {
            when(() => mockRemoteDataSource.getRandomPublicApi())
                .thenThrow(ServerException());

            final result = await repository.getRandomPublicApi();

            verify(() => mockRemoteDataSource.getRandomPublicApi());
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          }
      );
    });


    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(() => mockLocalDataSource.getLastPublicApi())
              .thenAnswer((_) async => publicApiModelTest);

          final result = await repository.getRandomPublicApi();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastPublicApi());
          expect(result, equals(Right(publicApiTest)));
        }
      );

      test(
          'should return CacheFailure cached data when there is no cached data present',
              () async {
            when(() => mockLocalDataSource.getLastPublicApi())
                .thenThrow(CacheException());

            final result = await repository.getRandomPublicApi();

            verifyZeroInteractions(mockRemoteDataSource);
            verify(() => mockLocalDataSource.getLastPublicApi());
            expect(result, equals(Left(CacheFailure())));
          }
      );
    });
  });
}