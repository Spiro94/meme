import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/base_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/meme.dart';
import '../models/meme_model.dart';

abstract class MemeRemoteDataSource {
  ///Calls the downVote endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<bool> downVote(String id);

  ///Calls the getMemes endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<Meme>> getMemes(int page);

  ///Calls the upVote endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<bool> upVote(String id);
}

class MemeRemoteDataSourceImpl implements MemeRemoteDataSource {
  final http.Client httpClient;

  MemeRemoteDataSourceImpl(this.httpClient);

  @override
  Future<bool> downVote(String id) {
    return Future.value(true);
  }

  @override
  Future<List<MemeModel>> getMemes(int page) async {
    List<MemeModel> list = List();

    try {
      http.Response response = await httpClient.get(
        BaseUrls.baseUrl + 'memes',
        headers: {'Content-Type': 'applcation/json'},
      );
      Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['success']) {
        for (var item in jsonBody['items']) {
          list.add(MemeModel.fromJson(item));
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
    return list;
  }

  @override
  Future<bool> upVote(String id) {
    return Future.value(true);
  }
}
