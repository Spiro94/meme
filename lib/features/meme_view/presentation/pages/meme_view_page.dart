import 'package:flutter/material.dart';
import 'package:meme/features/meme_view/data/models/meme_model.dart';
import 'package:meme/features/meme_view/presentation/interfaces/meme_view_interface.dart';
import 'package:meme/features/meme_view/presentation/presenters/meme_view_presenter.dart';

import '../widgets/meme_container.dart';

class MemeViewPage extends StatefulWidget {
  const MemeViewPage({Key key}) : super(key: key);

  @override
  _MemeViewPageState createState() => _MemeViewPageState();
}

class _MemeViewPageState extends State<MemeViewPage>
    implements MemeViewInterface {
  final int increment = 2;
  List<MemeModel> list;
  MemeViewPresenter _presenter;
  int pageSize;
  bool loading;
  String id;
  String title;

  @override
  void initState() {
    super.initState();
    _presenter = MemeViewPresenter(this);
    list = List();
    _presenter.getMemes(pageSize, id, title);
    pageSize = increment;
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colombian memes'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                pageSize += increment;
                _presenter.getMemes(pageSize, id, title);

                return;
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MemeContainer(
                    meme: list[index],
                  );
                },
                itemCount: list.length,
              ),
            ),
    );
  }

  @override
  void obtainedMemesSuccessful(List<MemeModel> memes) {
    setState(() {
      list.addAll(memes);
      if (memes.length > 0) {
        id = list.last.id;
        title = list.last.title;
      }
      loading = false;
    });
  }

  @override
  void showError() {
    setState(() {
      loading = false;
    });
    print('Error');
  }

  @override
  void showLoading() {
    setState(() {
      loading = true;
    });
  }

  @override
  void stopLoading() {
    setState(() {
      loading = false;
    });
  }
}
