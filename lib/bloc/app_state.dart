part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final bool successful;
  const AppState({required this.isLoading, required this.successful});
}

class AppStateLoggedIn extends AppState {
  AppStateLoggedIn({
    required isLoading,
    required successful,
  }) : super(isLoading: isLoading, successful: successful);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}

class AppStateLoggedOut extends AppState {
  AppStateLoggedOut({
    required isLoading,
    required successful,
  }) : super(isLoading: isLoading, successful: successful);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}

class AppStateLoading extends AppState {
  const AppStateLoading() : super(isLoading: true, successful: false);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}

class AppStateDataLoaded extends AppState {
  final List<dynamic> dataList;
  const AppStateDataLoaded(this.dataList) : super(isLoading: false, successful: true);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}

class AppStateError extends AppState {
  final String errorMessage;
  const AppStateError(this.errorMessage) : super(isLoading: false, successful: false);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}

