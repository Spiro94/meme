import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/data/models/meme_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMemeModel = MemeModel(
    id: 'M1611620581',
    category: 'funny',
    title: 'PRIMER MEME',
    imageUrl:
        'https://i1.wp.com/www.materiagris.es/wp-content/uploads/2018/10/meme.jpg?resize=400%2C320&ssl=1',
    upVotes: 5,
    downVotes: 1,
  );

  final List<MemeModel> tListMemeModel = [tMemeModel];

  test('should be a subclass of Meme entity', () async {
    //assert
    expect(tMemeModel, isA<MemeModel>());
  });
  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('memes.json'));
      //act
      List<MemeModel> result = List();
      for (var item in jsonMap['items']) {
        result.add(MemeModel.fromJson(item));
      }

      //assert
      expect(result, tListMemeModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange
      //act
      final result = tMemeModel.toJson();

      //assert
      final expectedMap = {
        'id': 'M1611620581',
        'title': 'PRIMER MEME',
        'imageUrl':
            'https://i1.wp.com/www.materiagris.es/wp-content/uploads/2018/10/meme.jpg?resize=400%2C320&ssl=1',
        'upVote': 5,
        'downVote': 1
      };
      expect(result, expectedMap);
    });
  });
}
