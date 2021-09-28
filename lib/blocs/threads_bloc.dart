import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_app/models/threads.dart';
import 'package:chat_app/repository/threads_repository.dart';
import 'package:rxdart/rxdart.dart';

enum AppBarState {
  SEARCH,
  IDLE,
}

class ThreadsBloc extends BlocBase {
  final ThreadsRepository repository;

  final _listController = BehaviorSubject<List<ThreadsModel>>();
  Stream get listStream => _listController.stream;

  final _appBarController = BehaviorSubject<AppBarState>();
  Stream get appBarStream => _appBarController.stream;

  ThreadsBloc(this.repository);

  void getList(String filter) async {
    _listController.sink.add(await repository.getList(filter));
  }

  void toggleAppBar(AppBarState appBarState) {
    _appBarController.sink.add(appBarState);
  }

  @override
  void dispose() {
    _listController.close();
    _appBarController.close();
    super.dispose();
  }
}
