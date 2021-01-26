import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/data/models/meme_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMemeModel = MemeModel(
      id: '1', title: 'test', imageUrl: 'test', upVotes: 0, downVotes: 0);

  test('should be a subclass of Meme entity', () async {
    //assert
    expect(tMemeModel, isA<MemeModel>());
  });
  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('memes.json'));
      //act
      final result = MemeModel.fromJson(jsonMap);
      //assert
      expect(result, tMemeModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange
      //act
      final result = tMemeModel.toJson();

      //assert
      final expectedMap = {
        "id": "1",
        "title": "test",
        "image_url": "test",
        "up_votes": 0,
        "down_votes": 0
      };
      expect(result, expectedMap);
    });
  });
}
