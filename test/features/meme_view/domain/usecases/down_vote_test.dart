import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/domain/repositories/meme_repository.dart';
import 'package:meme/features/meme_view/domain/usecases/down_vote.dart';
import 'package:meme/features/meme_view/domain/usecases/up_vote.dart';
import 'package:mockito/mockito.dart';

class MockMemeRepository extends Mock implements MemeRepository {}

void main() {
  DownVote usecase;
  MockMemeRepository mockMemeRepository;

  setUp(() {
    mockMemeRepository = MockMemeRepository();
    usecase = DownVote(mockMemeRepository);
  });
  final String tId = '1';
  final String tTitle = '1';

  test('should downvote a meme', () async {
    //arrange
    when(mockMemeRepository.downVote(any, any)).thenAnswer((_) async => true);
    //act
    final result = await usecase(
      id: tId,
      title: tTitle,
    );
    //assert
    expect(result, true);
    verify(mockMemeRepository.downVote(tId, tTitle));
    verifyNoMoreInteractions(mockMemeRepository);
  });
}
