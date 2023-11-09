Target getEmptyTarget(){
  return Target(
      id: 0,
      userId: 0,
      type: TypeTarget.loseWeight,
      targetWeight: 0,
      tempo: 0
  );
}

class Target{
  final int id;
  final int userId;
  final TypeTarget type;
  final int targetWeight;
  final double tempo;

  static String createSQL =
      "CREATE TABLE Target ("
        "Id	INTEGER NOT NULL UNIQUE, "
        "UserId INTEGER,"
        "Type	INTEGER, "
        "TargetWeight	INTEGER, "
        "Tempo REAL, "
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Target({
    required this.id,
    required this.userId,
    required this.type,
    required this.targetWeight,
    required this.tempo
  });

  factory Target.fromMap(Map<String, dynamic> json) => Target(
      id: json["Id"],
      userId: json["UserId"],
      type: json["Type"] == 0 ? TypeTarget.loseWeight
          : json["Type"] == 1 ? TypeTarget.holdWeight
          : TypeTarget.gainWeight,
      targetWeight: json["TargetWeight"],
      tempo: json["Tempo"]
  );
}

enum TypeTarget{
  loseWeight,
  holdWeight,
  gainWeight
}