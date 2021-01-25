import '../../domain/entities/meme.dart';
import 'package:meta/meta.dart';

class MemeModel extends Meme {
  MemeModel({
    @required String id,
    @required String imageUrl,
    @required int upVotes,
    @required int downVotes,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          upVotes: upVotes,
          downVotes: downVotes,
        );

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
      id: json['id'],
      imageUrl: json['image_url'],
      upVotes: json['up_votes'],
      downVotes: json['down_votes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image_url": imageUrl,
      "up_votes": upVotes,
      "down_votes": downVotes
    };
  }
}
