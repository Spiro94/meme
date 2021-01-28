import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';

import '../repositories/meme_repository.dart';

class UpVote implements UseCase<Future<bool>, int> {
  final MemeRepository repository;

  UpVote(this.repository);

  @override
  Future<bool> call({@required String id, @required String title}) async {
    return await repository.upVote(id, title);
  }
}
