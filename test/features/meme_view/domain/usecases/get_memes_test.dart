import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/domain/entities/meme.dart';
import 'package:meme/features/meme_view/domain/repositories/meme_repository.dart';
import 'package:meme/features/meme_view/domain/usecases/get_memes.dart';
import 'package:mockito/mockito.dart';

class MockMemeRepository extends Mock implements MemeRepository {}

void main() {
  GetMemes usecase;
  MockMemeRepository mockMemeRepository;

  setUp(() {
    mockMemeRepository = MockMemeRepository();
    usecase = GetMemes(mockMemeRepository);
  });
  final int tPage = 1;
  final List<Meme> tMemes = [
    Meme(id: '1', title: 'test', imageUrl: 'urlTest', upVotes: 0, downVotes: 0)
  ];

  test('should get a page of Memes from the repository', () async {
    //arrange
    when(mockMemeRepository.getMemes(any))
        .thenAnswer((_) async => Right(tMemes));
    //act
    final result = await usecase(page: tPage);
    //assert
    expect(result, Right(tMemes));
    verify(mockMemeRepository.getMemes(tPage));
    verifyNoMoreInteractions(mockMemeRepository);
  });
}
