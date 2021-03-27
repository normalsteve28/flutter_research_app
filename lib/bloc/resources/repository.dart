import 'dart:async';
import 'api.dart';
import '../../models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<Person> registerUser(
    String username,
    /* String firstname, String lastname,
          String password, String email */
  ) =>
      apiProvider.registerUser(username);

  Future signinUser(String username, /* String password, */ String apiKey) =>
      apiProvider.signinUser(username, apiKey);

  // ISSUE This program does not need Tasks, will delete later (or could possibly use for bp data)
  Future getUserTasks(String apiKey) => apiProvider.getUserTasks(apiKey);

  // ISSUE This program does not need Tasks, will delete later (or could possibly use for bp data)
  Future<Null> addUserTask(
      String apiKey, String taskName, String deadline) async {
    apiProvider.addUserTask(apiKey, taskName, deadline);
  }
}
