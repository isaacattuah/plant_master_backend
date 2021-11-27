class Plant {
  final int elementGlobalId;
  final String scientificName;
  final String primaryCommonName;
  final String taxonomicComments;
  final String informalTaxonomy;
  final String Kingdom;
  final String Phylum;
  final String Class;
  final String Order;
  final String Family;
  final String Genus;

  Plant({
    required this.elementGlobalId,
    required this.scientificName,
    required this.primaryCommonName,
    required this.taxonomicComments,
    required this.informalTaxonomy,
    required this.Kingdom,
    required this.Phylum,
    required this.Class,
    required this.Order,
    required this.Family,
    required this.Genus,

  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      elementGlobalId: json["elementGlobalId"],
      scientificName: json["scientificName"] ?? "No Data",
      primaryCommonName: json["primaryCommonName"] ?? "No Data" ,
      taxonomicComments: json["taxonomicComments"] ?? "No Data",
      informalTaxonomy: json["speciesGlobal"]["informalTaxonomy"]["level1"] + ' - ' + json["speciesGlobal"]["informalTaxonomy"]["level2"]
          + ' - ' + json["speciesGlobal"]["informalTaxonomy"]["level3"] ?? "No Data",
      Kingdom: json["speciesGlobal"]["kingdom"] ?? "No Data",
      Phylum:  json["speciesGlobal"]["phylum"] ?? "No Data",
      Class: json["speciesGlobal"]["taxclass"] ?? "No Data",
      Order: json["speciesGlobal"]["taxorder"] ?? "No Data",
      Family: json["speciesGlobal"]["family"] ?? "No Data",
      Genus: json["speciesGlobal"]["genus"] ?? "No Data",

    );
  }

  factory Plant.fromJsonSearch(Map<String, dynamic> json) {
    return Plant(
      elementGlobalId: json["elementGlobalId"],
      scientificName: json["scientificName"] ?? "No Data",
      primaryCommonName: json["primaryCommonName"] ?? "No Data" ,
      taxonomicComments: json["taxonomicComments"] ?? "No Data",
      informalTaxonomy: json["speciesGlobal"]["informalTaxonomy"] ?? "No Data",
      Kingdom: json["speciesGlobal"]["kingdom"] ?? "No Data",
      Phylum:  json["speciesGlobal"]["phylum"] ?? "No Data",
      Class: json["speciesGlobal"]["taxclass"] ?? "No Data",
      Order: json["speciesGlobal"]["taxorder"] ?? "No Data",
      Family: json["speciesGlobal"]["family"] ?? "No Data",
      Genus: json["speciesGlobal"]["genus"] ?? "No Data",

    );
  }

  static List<Plant> plantsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Plant.fromJsonSearch(data);
    }).toList();
  }

}