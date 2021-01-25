import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/meme.dart';
import '../repositories/meme_repository.dart';

class GetMemes implements UseCase<Future<Either<Failure, List<Meme>>>, int> {
  final MemeRepository repository;

  GetMemes(this.repository);

  @override
  Future<Either<Failure, List<Meme>>> call({@required int page}) async {
    return await repository.getMemes(page);
  }
}
