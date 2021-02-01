import '../../../../injection_container.dart';
import '../../domain/usecases/get_memes.dart';
import '../interfaces/meme_view_interface.dart';

class MemeViewPresenter {
  MemeViewInterface _interface;

  MemeViewPresenter(this._interface);

  Future<void> getMemes(
    int page,
    String id,
    String title,
  ) async {
    _interface.showLoading();
    final response = await sl<GetMemes>().call(
      page: page,
      id: id,
      title: title,
    );
    print('page $page');

    response.fold((err) {
      _interface.showError();
    }, (data) {
      _interface.obtainedMemesSuccessful(data);
    });
  }
}
