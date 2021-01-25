import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Meme extends Equatable {
  final String id;
  final String imageUrl;
  final int upVotes;
  final int downVotes;

  Meme({
    @required this.id,
    @required this.imageUrl,
    @required this.upVotes,
    @required this.downVotes,
  });

  @override
  List<Object> get props => [id, imageUrl, upVotes, downVotes];
}
