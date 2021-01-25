import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/meme.dart';

abstract class MemeRepository {
  Future<Either<Failure, List<Meme>>> getMemes(int page);
  Future<bool> downVote(String id);
  Future<bool> upVote(String id);
}
