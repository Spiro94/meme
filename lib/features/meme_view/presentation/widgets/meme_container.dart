import 'package:flutter/material.dart';

import 'package:meme/features/meme_view/domain/entities/meme.dart';
import 'package:meme/features/meme_view/domain/usecases/down_vote.dart';
import 'package:meme/features/meme_view/domain/usecases/up_vote.dart';
import 'package:meme/injection_container.dart';

class MemeContainer extends StatefulWidget {
  final Meme meme;
  const MemeContainer({this.meme, Key key}) : super(key: key);

  @override
  _MemeContainerState createState() => _MemeContainerState();
}

class _MemeContainerState extends State<MemeContainer> {
  int upVotes;
  int downVotes;

  @override
  void initState() {
    super.initState();
    upVotes = widget.meme.upVotes;
    downVotes = widget.meme.downVotes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Container(
            height: 40,
            child: Center(
              child: Text(
                widget.meme.title,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          FadeInImage(
            placeholder: AssetImage('assets/images/Placeholder.png'),
            image: NetworkImage(widget.meme.imageUrl),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.arrow_upward),
                        Text(upVotes.toString()),
                      ],
                    ),
                    onPressed: () async {
                      bool response = await sl<UpVote>().call(
                        id: widget.meme.id,
                        title: widget.meme.title,
                      );
                      if (response) {
                        upVotes++;
                        widget.meme.upVotes++;
                      }
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.arrow_downward),
                        Text(downVotes.toString()),
                      ],
                    ),
                    onPressed: () async {
                      bool response = await sl<DownVote>().call(
                        id: widget.meme.id,
                        title: widget.meme.title,
                      );
                      if (response) {
                        downVotes++;
                        widget.meme.downVotes++;
                      }

                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
