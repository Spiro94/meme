import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/data/datasources/meme_remote_data_source.dart';
import 'package:meme/features/meme_view/data/models/meme_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MemeRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MemeRemoteDataSourceImpl(mockHttpClient);
  });

  group('getMemes', () {
    final int tPage = 1;
    final List<MemeModel> tMemeModelList = [
      MemeModel.fromJson(json.decode(fixture('memes.json')))
    ];

    test('should perfom a GET request on a URL', () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('memes.json'), 200));
      //act
      dataSource.getMemes(tPage);
      //assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/$tPage',
        headers: {'Content-Type': 'applcation/json'},
      ));
    });
  });
}
