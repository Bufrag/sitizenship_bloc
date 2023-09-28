import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sitizenship_bloc/resourse/api_repository.dart';

import '../model/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<GetUserList>((event, emit) async {
      try {
        emit(UserLoading());
        final countries = await _apiRepository.fetchUserList();
        emit(UserLoaded(countries));
      } on NetworkError {
        emit(const UserError("Ошибка , вы вообще в сети?"));
      }
    });
  }
}
