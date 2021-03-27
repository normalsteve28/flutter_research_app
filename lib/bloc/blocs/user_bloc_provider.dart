import '../../models/classes/task.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/classes/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<Person>();

  Observable<Person> get getUser => _userGetter.stream;

  registerUser(
    String username,
    /* String firstname, String lastname,
      String password, String email*/
  ) async {
    Person user = await _repository.registerUser(username);
    _userGetter.sink.add(user);
  }

  signinUser(String username, /* String password, */ String apiKey) async {
    Person user = await _repository.signinUser(username, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

// ISSUE This program does not need Tasks, will delete later (or could possibly use for bp data)
class TaskBloc {
  final _repository = Repository();
  final _taskSubject = BehaviorSubject<List<Task>>();
  String apiKey;

  var _tasks = <Task>[];

  TaskBloc(String api_key) {
    this.apiKey = api_key;
    _updateTasks(api_key).then((_) {
      _taskSubject.add(_tasks);
    });
  }

  Stream<List<Task>> get getTasks => _taskSubject.stream;

  Future<Null> _updateTasks(String apiKey) async {
    _tasks = await _repository.getUserTasks(apiKey);
  }
}

final userBloc = UserBloc();
