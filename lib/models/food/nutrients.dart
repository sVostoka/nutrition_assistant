Nutrients getEmptyNutrients(){
  return Nutrients(
      id: 0,
      productId: "",
      enercKCal: 0,
      procnt: 0,
      fat: 0,
      chocdf: 0,
      fibig: 0
  );
}

class Nutrients{
  int id;
  final String productId;
  final double enercKCal; //Energy
  final double procnt; //Protein
  final double fat; //Fats
  final double chocdf; //Carbohydrate, by difference
  final double fibig; //Fiber, total dietary

  static String createSQL =
      "CREATE TABLE Nutrients ("
        "Id	INTEGER NOT NULL UNIQUE,"
        "ProductId	TEXT,"
        "ENERCKCAL	REAL,"
        "PROCNT	REAL,"
        "FAT	REAL,"
        "CHOCDF	REAL,"
        "FIBTG	REAL,"
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Nutrients({
    this.id = 0,
    required this.productId,
    required this.enercKCal,
    required this.procnt,
    required this.fat,
    required this.chocdf,
    required this.fibig,
  });

  factory Nutrients.fromMap(Map<String, dynamic> json) => Nutrients(
      id: json["Id"],
      productId: json["ProductId"],
      enercKCal: json["ENERCKCAL"],
      procnt: json["PROCNT"],
      fat: json["FAT"],
      chocdf: json["CHOCDF"],
      fibig: json["FIBTG"]
  );
}