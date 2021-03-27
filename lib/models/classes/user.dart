// import 'package:flutter/rendering.dart'; commented out because unused

class Person {
  String username;
  String api_key;
  int id;

  Person(this.id, this.username, this.api_key);

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    return Person(
        parsedJson['id'], parsedJson['username'], parsedJson['api_key']);
  }
}
