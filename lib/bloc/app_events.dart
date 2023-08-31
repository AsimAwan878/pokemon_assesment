part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}


class AppEventLogOut extends AppEvent {
  const AppEventLogOut();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AppEventLogIn extends AppEvent {
  final String email;
  final String password;
  const AppEventLogIn({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class AppEventRegister extends AppEvent {
  final String email;
  final String password;
  const AppEventRegister({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}