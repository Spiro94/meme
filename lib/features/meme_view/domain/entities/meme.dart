import 'package:flutter/material.dart';

class Meme {
  final String id;
  final String title;
  final String imageUrl;
  String category;
  int upVotes;
  int downVotes;

  Meme({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.imageUrl,
    @required this.upVotes,
    @required this.downVotes,
  });
}
