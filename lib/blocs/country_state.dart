part of 'country_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<Countries> countries;

  const UserLoaded(this.countries);
}

final class UserError extends UserState {
  final String? message;

  const UserError(this.message);
}
