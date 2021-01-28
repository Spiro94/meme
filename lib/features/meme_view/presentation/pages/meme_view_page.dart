import 'package:flutter/material.dart';
import 'package:meme/features/meme_view/domain/usecases/get_memes.dart';
import 'package:meme/injection_container.dart';

class MemeViewPage extends StatelessWidget {
  const MemeViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colombian memes'),
      ),
      body: FutureBuilder(
        future: sl<GetMemes>().call(page: 1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: Container(
              child: Text('!!!'),
            ),
          );
        },
      ),
    );
  }
}
