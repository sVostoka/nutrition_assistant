Measure getEmptyMeasure(){
  return Measure(
      id: 0,
      productId: "",
      uri: "",
      label: "",
      weight: 0
  );
}

class Measure{
  int id;
  final String productId;
  final String uri;
  final String label;
  final double weight;

  static String createSQL =
      "CREATE TABLE Measure ("
        "Id	INTEGER NOT NULL UNIQUE,"
        "ProductId	TEXT,"
        "URI	TEXT,"
        "Label	TEXT,"
        "Weight	REAL,"
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Measure({
    this.id = 0,
    required this.productId,
    required this.uri,
    required this.label,
    required this.weight,
  });

  factory Measure.fromMap(Map<String, dynamic> json) => Measure(
      id: json["Id"],
      productId: json["ProductId"],
      uri: json["URI"],
      label: json["Label"],
      weight: json["Weight"]
  );
}