import 'package:sitizenship_bloc/resourse/api_provider.dart';

import '../model/country_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<Countries>> fetchUserList() {
    return _provider.fetchCountryModel();
  }
}

class NetworkError extends Error {}
