import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme/core/error/exceptions.dart';
import 'package:meme/core/error/failures.dart';
import 'package:meme/core/network/network_info.dart';
import 'package:meme/features/meme_view/data/datasources/meme_remote_data_source.dart';
import 'package:meme/features/meme_view/data/models/meme_model.dart';
import 'package:meme/features/meme_view/data/repositories/meme_repository_impl.dart';
import 'package:meme/features/meme_view/domain/entities/meme.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements MemeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MemeRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MemeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getMemes', () {
    final tPage = 1;
    final tMemeModel = MemeModel(
        id: '1', title: 'test', imageUrl: 'test', upVotes: 0, downVotes: 0);
    final Meme tMeme = tMemeModel;
    final tListMemeModel = [tMemeModel];
    final List<Meme> tListMeme = tListMemeModel;

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getMemes(tPage);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMemes(any)).thenAnswer(
            (_) async => tListMeme); //The repository return entities not models
        //act
        final result = await repository.getMemes(tPage);
        //assert
        verify(mockRemoteDataSource.getMemes(tPage));
        expect(result, Right(tListMemeModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMemes(any)).thenThrow(ServerException());
        //act
        final result = await repository.getMemes(tPage);
        //assert
        verify(mockRemoteDataSource.getMemes(tPage));
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return server exception', () async {
        //arrange
        when(mockRemoteDataSource.getMemes(any)).thenAnswer(
            (_) async => tListMeme); //The repository return entities not models
        //act
        final result = await repository.getMemes(tPage);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('upVote', () {
    final String tId = '1';

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.upVote(tId);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.upVote(any)).thenAnswer((_) async => true);
        //act
        final result = await repository.upVote(tId);
        //assert
        verify(mockRemoteDataSource.upVote(tId));
        expect(result, true);
      });

      test(
          'should return false when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.upVote(any)).thenThrow(ServerException());
        //act
        final result = await repository.upVote(tId);
        //assert
        verify(mockRemoteDataSource.upVote(tId));
        expect(result, false);
      });
    });

    runTestsOffline(() {
      test('should return server exception', () async {
        //arrange
        when(mockRemoteDataSource.upVote(any)).thenAnswer((_) async => true);
        //act
        final result = await repository.upVote(tId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, false);
      });
    });
  });

  group('downVote', () {
    final String tId = '1';

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.downVote(tId);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.downVote(any)).thenAnswer((_) async => true);
        //act
        final result = await repository.downVote(tId);
        //assert
        verify(mockRemoteDataSource.downVote(tId));
        expect(result, true);
      });

      test(
          'should return false when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.downVote(any)).thenThrow(ServerException());
        //act
        final result = await repository.downVote(tId);
        //assert
        verify(mockRemoteDataSource.downVote(tId));
        expect(result, false);
      });
    });

    runTestsOffline(() {
      test('should return server exception', () async {
        //arrange
        when(mockRemoteDataSource.downVote(any)).thenAnswer((_) async => true);
        //act
        final result = await repository.downVote(tId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, false);
      });
    });
  });
}
