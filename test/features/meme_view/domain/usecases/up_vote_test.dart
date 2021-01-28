import 'package:flutter_test/flutter_test.dart';
import 'package:meme/features/meme_view/domain/repositories/meme_repository.dart';
import 'package:meme/features/meme_view/domain/usecases/up_vote.dart';
import 'package:mockito/mockito.dart';

class MockMemeRepository extends Mock implements MemeRepository {}

void main() {
  UpVote usecase;
  MockMemeRepository mockMemeRepository;

  setUp(() {
    mockMemeRepository = MockMemeRepository();
    usecase = UpVote(mockMemeRepository);
  });
  final String tId = '1';
  final String tTitle = '1';

  test('should upvote a meme', () async {
    //arrange
    when(mockMemeRepository.upVote(any, any)).thenAnswer((_) async => true);
    //act
    final result = await usecase(
      id: tId,
      title: tTitle,
    );
    //assert
    expect(result, true);
    verify(mockMemeRepository.upVote(tId, tTitle));
    verifyNoMoreInteractions(mockMemeRepository);
  });
}
