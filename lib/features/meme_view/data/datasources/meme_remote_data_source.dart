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
  Future<bool> downVote(String id, String title);

  ///Calls the getMemes endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<Meme>> getMemes(int pageSize, String id, String title);

  ///Calls the upVote endpoint
  ///
  ///Throws a [ServerException] for all error codes
  Future<bool> upVote(String id, String title);
}

class MemeRemoteDataSourceImpl implements MemeRemoteDataSource {
  final http.Client httpClient;

  MemeRemoteDataSourceImpl(this.httpClient);

  @override
  Future<bool> downVote(String id, String title) async {
    try {
      http.Response response = await httpClient.post(
        BaseUrls.baseUrl + 'downVote',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'id': id, 'title': title},
        encoding: Encoding.getByName("utf-8"),
      );
      Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['success']) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<MemeModel>> getMemes(
      int pageSize, String id, String title) async {
    List<MemeModel> list = List();

    try {
      http.Response response = await httpClient.post(
        BaseUrls.baseUrl + 'memes',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'pageSize': pageSize,
          'id': id,
        },
        encoding: Encoding.getByName("utf-8"),
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
  Future<bool> upVote(String id, String title) async {
    try {
      http.Response response = await httpClient.post(
        BaseUrls.baseUrl + 'upVote',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'id': id, 'title': title},
        encoding: Encoding.getByName("utf-8"),
      );
      Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['success']) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
