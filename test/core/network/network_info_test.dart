import 'package:clean_app_flutter/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  MockInternetConnectionChecker mockInternetConnectionChecker = MockInternetConnectionChecker();
  NetworkInfoImpl networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
    () async {
      final hasConnectionFutureTest = Future.value(true);

      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => hasConnectionFutureTest);

      final result = networkInfoImpl.isConnected;

      verify(() => mockInternetConnectionChecker.hasConnection);
      expect(result, hasConnectionFutureTest);
    });
  });

}