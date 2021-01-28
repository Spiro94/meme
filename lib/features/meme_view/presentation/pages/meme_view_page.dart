import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/meme.dart';
import '../../domain/usecases/get_memes.dart';
import '../widgets/meme_container.dart';

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
          if (snapshot.connectionState == ConnectionState.done) {
            Widget widget;
            snapshot.data.fold((Failure err) {
              widget = Center(
                child: Container(
                  child: Text('Error'),
                ),
              );
            }, (List<Meme> data) {
              widget = ListView.builder(
                itemBuilder: (context, index) {
                  return MemeContainer(
                    meme: data[index],
                  );
                },
                itemCount: data.length,
              );
            });
            return widget;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
