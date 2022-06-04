import 'dart:convert';

import 'package:clean_app_flutter/features/public_api/data/models/public_api_model.dart';
import 'package:clean_app_flutter/features/public_api/domain/entities/public_api.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {

  final publicApiTest = PublicApiModel(apiName: "CoinCap", description: "Real time Cryptocurrency prices through a RESTful API", category: "Cryptocurrency", link: "https://docs.coincap.io/", isHttps: true);

  test(
    'should be a subclass of PublicApi entity',
    () async {
      expect(publicApiTest, isA<PublicApi>());
    }
  );

  group('fromJson', () {
    test(
      'should return a valid model with all fields populated',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(fixture('public_api.json'));

        final result = PublicApiModel.fromJson(jsonMap['entries'][0]);

        expect(result, publicApiTest);
      }
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        final result = publicApiTest.toJson();

        final expectedMap = {
          "API": "CoinCap",
          "Description": "Real time Cryptocurrency prices through a RESTful API",
          "HTTPS": true,
          "Link": "https://docs.coincap.io/",
          "Category": "Cryptocurrency"
        };

        expect(result, expectedMap);
      }
    );
  });
}