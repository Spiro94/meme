import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/meme.dart';
import '../../domain/repositories/meme_repository.dart';
import '../datasources/meme_remote_data_source.dart';

class MemeRepositoryImpl implements MemeRepository {
  final MemeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MemeRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<bool> downVote(String id, String title) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.downVote(id, title);
      } on ServerException {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<Either<Failure, List<Meme>>> getMemes(int page) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getMemes(page));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<bool> upVote(String id, String title) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.upVote(id, title);
      } on ServerException {
        return false;
      }
    } else {
      return false;
    }
  }
}
