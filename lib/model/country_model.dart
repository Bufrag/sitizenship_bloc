// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) =>
    List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  String years;
  String europe;
  String imagePath;
  String taxRate;
  String population;
  String name;
  String imageUrl;
  bool isEuropen;
  bool isPopular;
  bool isFastPassport;

  Countries({
    required this.years,
    required this.europe,
    required this.imagePath,
    required this.taxRate,
    required this.population,
    required this.name,
    required this.imageUrl,
    required this.isEuropen,
    required this.isPopular,
    required this.isFastPassport,
  });

  factory Countries.fromJson(Map<dynamic, dynamic> json) => Countries(
        //вот здесь была ошибка связанная с String ее надо была заменить на dynamic
        years: json["Years"],
        europe: json["Europe"],
        imagePath: json["ImagePath"],
        taxRate: json["TaxRate"],
        population: json["Population"],
        name: json["Name"],
        imageUrl: json["imageUrl"],
        isEuropen: json["isEuropen"],
        isFastPassport: json["isFastPassport"],
        isPopular: json["isPopular"],
      );

  Map<String, dynamic> toJson() => {
        "Years": years,
        "Europe": europe,
        "ImagePath": imagePath,
        "TaxRate": taxRate,
        "Population": population,
        "Name": name,
        "imageUrl": imageUrl,
        "isEuropen": isEuropen,
        "isFastPassport": isFastPassport,
        "isPopular": isPopular,
      };
  static final List<Countries> _favouriteCountries = [];
  static List<Countries> get getFavouritesCountry => _favouriteCountries;
  static void addToFavouritesCountries(Countries countries) {
    _favouriteCountries.add(countries);
  }

  static void removeFavouritesCountries(Countries countries) {
    _favouriteCountries.remove(countries);
  }
}
