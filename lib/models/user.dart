User getEmptyUser(){
  return User(
      id: 0,
      username: "empty",
      gender: Gender.man,
      weight: 0,
      height: 0,
      dateOfBirth: DateTime.now()
  );
}

class User{
  final int id;
  final String username;
  final Gender gender;
  final int weight;
  final int height;
  final DateTime dateOfBirth;

  static String createSQL =
      "CREATE TABLE User ("
        "Id	INTEGER NOT NULL UNIQUE, "
        "Username	TEXT, "
        "Gender	INTEGER, "
        "Weight INTEGER, "
        "Height	INTEGER, "
        "DateOfBirth TEXT, "
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  User({
    required this.id,
    required this.username,
    required this.gender,
    required this.weight,
    required this.height,
    required this.dateOfBirth
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["Id"],
      username: json["Username"],
      gender: (json["Gender"] == "1" ? Gender.woman : Gender.man),
      weight: json["Weight"],
      height: json["Height"],
      dateOfBirth: DateTime.parse(json["DateOfBirth"]),
  );
}

enum Gender{
  woman,
  man
}