import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meme/features/meme_view/domain/entities/meme.dart';
import 'package:http/http.dart' as http;

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
  Future<List<Meme>> getMemes(int page) async {
    return null;
  }

  @override
  Future<bool> upVote(String id) {
    return Future.value(true);
  }
}
