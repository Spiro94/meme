import '../../domain/entities/meme.dart';
import 'package:meta/meta.dart';

class MemeModel extends Meme {
  MemeModel({
    @required String id,
    @required String title,
    @required String category,
    @required String imageUrl,
    @required int upVotes,
    @required int downVotes,
  }) : super(
          id: id,
          title: title,
          category: category,
          imageUrl: imageUrl,
          upVotes: upVotes,
          downVotes: downVotes,
        );

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      upVotes: json['upVote'],
      downVotes: json['downVote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "imageUrl": imageUrl,
      "upVote": upVotes,
      "downVote": downVotes
    };
  }
}
