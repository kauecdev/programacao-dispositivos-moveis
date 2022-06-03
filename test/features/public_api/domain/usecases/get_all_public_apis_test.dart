import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:clean_app_flutter/features/public_api/domain/repositories/public_api_repository.dart';
import 'package:clean_app_flutter/features/public_api/domain/usecases/get_random_public_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicApiRepository extends Mock implements PublicApiRepository {}

void main() {
  final mockPublicApiRepository = MockPublicApiRepository();
  final usecase = GetRandomPublicApi(mockPublicApiRepository);

  final publicApiTest = PublicApi(API: "API", description: "This is for test", category: "test", link: "http://test.com", https: false);

  test(
    'should get a random public api from the repository',
    () async {
      when(() => mockPublicApiRepository.getRandomPublicApi())
          .thenAnswer((_) async => Right(publicApiTest));

      final result = await usecase.execute();

      expect(result, Right(publicApiTest));
      verify(() => mockPublicApiRepository.getRandomPublicApi());
      verifyNoMoreInteractions(mockPublicApiRepository);
    }
  );
}