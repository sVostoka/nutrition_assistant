Nutrient getEmptyIngredient(){
  return Nutrient(
      totalLabel: "",
      label: "",
      quantity: 0,
      unit: ""
  );
}

class Nutrient{
  final int id;
  final String recipeId;
  final String totalLabel;
  final String label;
  final double quantity;
  final String unit;

  static String createSQL =
      "CREATE TABLE Nutrient ("
        "Id	INTEGER NOT NULL UNIQUE,"
        "RecipeId TEXT,"
        "TotalLabel	TEXT,"
        "Label	TEXT,"
        "Quantity	REAL,"
        "Unit	TEXT,"
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Nutrient({
    this.id = 0,
    this.recipeId = "",
    required this.totalLabel,
    required this.label,
    required this.quantity,
    required this.unit,
  });

  factory Nutrient.fromMapOnAPI(String totalLabel,
      Map<String, dynamic> json) => Nutrient(
        totalLabel: totalLabel ?? "",
        label: json["label"] ?? "",
        quantity: json["quantity"].toDouble() ?? 0,
        unit: json["unit"] ?? ""
  );

  factory Nutrient.fromMapOnDB(Map<String, dynamic> json) => Nutrient(
      totalLabel: json["TotalLabel"] ?? "",
      label: json["Label"] ?? "",
      quantity: json["Quantity"],
      unit: json["Unit"] ?? ""
  );
}