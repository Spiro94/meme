import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme/core/constants/base_urls.dart';
import 'package:meme/core/error/exceptions.dart';
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
  final tId = 'M1611620581';
  final tTitle = 'PRIMER MEME';

  void setUpHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('memes.json'), 200));
  }

  void setUpHttpClientUnsuccessful() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('memes_unsuccessful.json'), 404));
  }

  void setUpHttpClientSuccessPost() {
    when(mockHttpClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(fixture('memes.json'), 200));
  }

  void setUpHttpClientUnsuccessfulPost() {
    when(mockHttpClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async =>
        http.Response(fixture('vote_memes_unsuccessful.json'), 404));
  }

  group('getMemes', () {
    final int tPage = 1;
    final Map<String, dynamic> jsonMap = json.decode(fixture('memes.json'));
    final List<MemeModel> tMemeModelList = List();

    for (var item in jsonMap['items']) {
      tMemeModelList.add(MemeModel.fromJson(item));
    }

    test('should perfom a GET request on the URL', () async {
      //arrange
      setUpHttpClientSuccess();
      //act
      dataSource.getMemes(tPage);
      //assert
      verify(mockHttpClient.get(
        BaseUrls.baseUrl + 'memes',
        headers: {'Content-Type': 'applcation/json'},
      ));
    });

    test('should return a list of MemeModel when the response is Success',
        () async {
      //arrange
      setUpHttpClientSuccess();
      //act
      final result = await dataSource.getMemes(tPage);
      //assert
      expect(result, tMemeModelList);
    });

    test('should throw a ServerException when the response is not Success ',
        () async {
      //arrange
      setUpHttpClientUnsuccessful();
      //act
      final call = dataSource.getMemes;
      //assert
      expect(() => call(tPage), throwsA(isA<ServerException>()));
    });
  });

  group('upVote', () {
    test('should perfom a POST request on the URL', () async {
      //arrange
      setUpHttpClientSuccessPost();
      //act
      dataSource.upVote(tId, tTitle);
      //assert
      verify(
        mockHttpClient.post(
          BaseUrls.baseUrl + 'upVote',
          headers: {'Content-Type': 'applcation/json'},
          body: json.encode({'id': tId, 'title': tTitle}),
        ),
      );
    });

    test('should return True when the response is Success', () async {
      //arrange
      setUpHttpClientSuccessPost();
      //act
      final result = await dataSource.upVote(tId, tTitle);
      //assert
      expect(true, result);
    });
    test('should throw a ServerException when the response is not Success',
        () async {
      //arrange
      setUpHttpClientUnsuccessfulPost();
      //act
      final call = dataSource.upVote;
      //assert
      expect(() => call(tId, tTitle), throwsA(isA<ServerException>()));
    });
  });

  group('downVote', () {
    test('should perfom a POST request on the URL', () async {
      //arrange
      setUpHttpClientSuccessPost();
      //act
      dataSource.downVote(tId, tTitle);
      //assert
      verify(
        mockHttpClient.post(
          BaseUrls.baseUrl + 'upVote',
          headers: {'Content-Type': 'applcation/json'},
          body: json.encode({'id': tId, 'title': tTitle}),
        ),
      );
    });

    test('should return True when the response is Success', () async {
      //arrange
      setUpHttpClientSuccessPost();
      //act
      final result = await dataSource.downVote(tId, tTitle);
      //assert
      expect(true, result);
    });
    test('should throw a ServerException when the response is not Success',
        () async {
      //arrange
      setUpHttpClientUnsuccessfulPost();
      //act
      final call = dataSource.downVote;
      //assert
      expect(() => call(tId, tTitle), throwsA(isA<ServerException>()));
    });
  });
}
