Meal getEmptyMeal(){
  return Meal(
      id: 0,
      name: "",
      dateTime: DateTime.now(),
      calories: 0
  );
}

class Meal{
  final int id;
  final String name;
  final DateTime dateTime;
  final double calories;

  static String createSQL =
      "CREATE TABLE Meal ("
        "Id	INTEGER NOT NULL UNIQUE, "
        "Name TEXT,"
        "DateTime	TEXT, "
        "Calories	REAL, "
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Meal({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.calories
  });

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
    id: json["Id"],
    name: json["Name"],
    dateTime: DateTime.parse(json["DateTime"]),
    calories: json["Calories"]
  );
}