class DataModel {
  DataModel({
    required this.idState,
    required this.state,
    required this.idYear,
    required this.year,
    required this.population,
    required this.slugState,
  });

  final String idState;
  final String state;
  final int idYear;
  final String year;
  final int population;
  final String slugState;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        idState: json["ID State"],
        state: json["State"],
        idYear: json["ID Year"],
        year: json["Year"],
        population: json["Population"],
        slugState: json["Slug State"],
      );

  Map<String, dynamic> toJson() => {
        "ID State": idState,
        "State": state,
        "ID Year": idYear,
        "Year": year,
        "Population": population,
        "Slug State": slugState,
      };
}
