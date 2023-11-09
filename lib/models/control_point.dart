ControlPoint getEmptyControlPoint(){
  return ControlPoint(
    id: 0,
    userId: 0,
    targetId: 0,
    weight: 0,
    dateTime: DateTime.now()
  );
}

class ControlPoint {
  final int id;
  final int userId;
  final int targetId;
  final int weight;
  final DateTime dateTime;

  static String createSQL =
      "CREATE TABLE ControlPoint ("
        "Id	INTEGER NOT NULL UNIQUE, "
        "UserId INTEGER,"
        "TargetId	INTEGER, "
        "Weight	INTEGER, "
        "DateTime TEXT, "
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  ControlPoint({
    required this.id,
    required this.userId,
    required this.targetId,
    required this.weight,
    required this.dateTime
  });

  factory ControlPoint.fromMap(Map<String, dynamic> json) => ControlPoint(
      id: json["Id"],
      userId: json["UserId"],
      targetId: json["TargetId"],
      weight: json["Weight"],
      dateTime: DateTime.parse(json["DateTime"])
  );
}