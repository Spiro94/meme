import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Meme extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final int upVotes;
  final int downVotes;

  Meme({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.imageUrl,
    @required this.upVotes,
    @required this.downVotes,
  });

  @override
  List<Object> get props => [id, title, category, imageUrl, upVotes, downVotes];
}
