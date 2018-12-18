import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topsIds = PublishSubject<List<int>>();

  // Getter to streams
  Observable<List<int>> get topIds => _topsIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopsIds();
    _topsIds.sink.add(ids);
  }

  dispose() {
    _topsIds.close();
  }
}
