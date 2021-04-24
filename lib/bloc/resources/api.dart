import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/classes/task.dart';
import 'dart:convert';
import '../../models/classes/user.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<Person> registerUser(String username) async {
    final response =
        await client.post("https://healthappdatabase.herokuapp.com/api/signup",
            // headers: "",
            body: jsonEncode({
              "username": username,
            }));
    final Map result = json.decode(response.body);
    final int id = result["status"].length - 1;
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      print(result);
      await saveApiKey(result["data"]["api_key"]);
      return Person.fromJson(result["data"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future signinUser(String username, String apiKey) async {
    final response =
        await client.post("https://healthappdatabase.herokuapp.com/api/signup",
            headers: {"Authorization": apiKey},
            body: jsonEncode({
              "username": username,
            }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // This program does not need Tasks, will delete later (or could possibly use for bp data)
  Future<List<Task>> getUserTasks(String apiKey) async {
    final response = await client.get(
      "https://healthappdatabase.herokuapp.com/api/signup",
      headers: {"Authorization": apiKey},
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      List<Task> tasks = [];
      for (Map json_ in result["data"]) {
        try {
          tasks.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      for (Task task in tasks) {
        print(task.taskId);
      }
      return tasks;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load tasks');
    }
  }

  // This program does not need Tasks, will delete later (or could possibly use for bp data)
  Future addUserTask(String apiKey, String taskName, String deadline) async {
    final response = await client.post("http://127.0.0.1:5000/api/tasks",
        headers: {"Authorization": apiKey},
        body: jsonEncode({
          "note": "",
          "repeats": "",
          "completed": false,
          "deadline": deadline,
          "reminders": "",
          "title": taskName
        }));
    if (response.statusCode == 201) {
      print("Task added");
    } else {
      // If that call was not successful, throw an error.
      print(json.decode(response.body));
      throw Exception('Failed to load tasks');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', api_key);
  }
}
