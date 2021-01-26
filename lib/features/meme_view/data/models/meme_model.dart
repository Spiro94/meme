import '../../domain/entities/meme.dart';
import 'package:meta/meta.dart';

class MemeModel extends Meme {
  MemeModel({
    @required String id,
    @required String title,
    @required String imageUrl,
    @required int upVotes,
    @required int downVotes,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          upVotes: upVotes,
          downVotes: downVotes,
        );

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      upVotes: json['up_votes'],
      downVotes: json['down_votes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image_url": imageUrl,
      "up_votes": upVotes,
      "down_votes": downVotes
    };
  }
}
