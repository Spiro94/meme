import '../../../../core/usecases/usecase.dart';
import '../repositories/meme_repository.dart';
import 'package:meta/meta.dart';

class DownVote implements UseCase<Future<bool>, String> {
  final MemeRepository repository;

  DownVote(this.repository);

  @override
  Future<bool> call({@required String id, @required String title}) async {
    return await repository.downVote(id, title);
  }
}
