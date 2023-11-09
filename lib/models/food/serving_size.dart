ServingSizes getEmptyServingSize(){
  return ServingSizes(
      id: 0,
      productId: "",
      uri: "",
      label: "",
      quantity: 0
  );
}

class ServingSizes{
  int id;
  final String productId;
  final String uri;
  final String label;
  final double quantity;

  static String createSQL =
      "CREATE TABLE ServingSize ("
        "Id	INTEGER NOT NULL UNIQUE,"
        "ProductId	TEXT,"
        "URI	TEXT,"
        "Label	TEXT,"
        "Quantity	REAL,"
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  ServingSizes({
    this.id = 0,
    required this.productId,
    required this.uri,
    required this.label,
    required this.quantity,
  });

  factory ServingSizes.fromMap(Map<String, dynamic> json) => ServingSizes(
      id: json["Id"],
      productId: json["ProductId"],
      uri: json["URI"],
      label: json["Label"],
      quantity: json["Quantity"]
  );
}