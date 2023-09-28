import 'package:firebase_database/firebase_database.dart';
import 'package:sitizenship_bloc/model/country_model.dart';

// class ApiProvider {
//   Future<CountryModel?> fetchUserList() async {
//     final ref = FirebaseDatabase.instance.ref();
//     final snapshot = await ref.child("countries").get();
//     if (snapshot.exists) {
//       print(snapshot.exists);
//     } else {
//       print("NO data available");
//     }
//   }
// }

class ApiProvider {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<List<Countries>> fetchCountryModel() async {
    try {
      DataSnapshot snapshot = await ref.get(); // Чтение данных из корневого уровня , тут нет папки countries и я сделал так

      if (snapshot.exists) {
        final data = snapshot.value;
        print(data);

        if (data is List) {
          final countries = data
              .map((countryData) => Countries.fromJson(countryData))
              .toList();
          return countries;
        }
      }
      throw Exception("Ошибка получения данных");
    } catch (error) {
      print("Обнаружена ошибка: $error");
      throw Exception("Ошибка при получении данных");
    }
  }
}



    //   print("DatabaseEvent type = ${event.snapshot.runtimeType}");

    //   return ref.child("countries").onValue.map((event) {
    //     final dataSnapshot = event.snapshot;
    //     if (dataSnapshot.value != null) {
    //       Map<dynamic, dynamic>? data = dataSnapshot.value as Map?;

    //       if (data == null || !data.containsKey("countries")) {
    //         // Обработка случаев, когда данные не соответствуют ожиданиям.
    //         throw Exception("Ошибка получения данных");
    //       }

    //       List<dynamic> countriesData = data["countries"];
    //       List<Countries> countries = countriesData.map((countryData) {
    //         return Countries.fromJson(countryData);
    //       }).toList();

    //       return countries;
    //     } else {
    //       // Снимка данных нет.
    //       throw Exception("Данные не найдены");
    //     }
    //   });
    // }
  

