// import 'package:flutter/rendering.dart'; commented out because unused

class Person {
  String username;
  String apiKey;
  int id;

  Person(this.id, this.username, this.apiKey);

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    return Person(
        parsedJson['id'], parsedJson['username'], parsedJson['api_key']);
  }
}
