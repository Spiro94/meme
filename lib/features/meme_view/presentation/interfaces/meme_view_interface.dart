import '../../data/models/meme_model.dart';

abstract class MemeViewInterface {
  void obtainedMemesSuccessful(List<MemeModel> memes);
  void showError();
  void showLoading();
  void stopLoading();
}
