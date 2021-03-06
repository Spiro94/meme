import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/meme.dart';

abstract class MemeRepository {
  Future<Either<Failure, List<Meme>>> getMemes(
    int pageSize,
    String id,
    String title,
  );
  Future<bool> downVote(String id, String title);
  Future<bool> upVote(String id, String title);
}
