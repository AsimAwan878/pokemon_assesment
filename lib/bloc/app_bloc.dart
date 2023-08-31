import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon/auth/auth.dart';
import 'package:pokemon/auth/auth_error.dart';
import 'package:http/http.dart' as http;
part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppStateLoggedOut(isLoading: false, successful: false)) {
    on<AppEventLogIn>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print("Login c = $e");
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventLogOut>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signOut();
        emit(AppStateLoggedOut(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print("logout Exception = $e");

      }
    });

    on<AppEventRegister>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().createUserWithEmailAndPassword(email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print("Sign up Exception = $e");
        authErrorRegister = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventFetchData>((event, emit) async {
      emit(AppStateLoading());
      try {
        final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));
        if (response.statusCode == 200) {
          final List<dynamic> dataList = json.decode(response.body)['results'];
          emit(AppStateDataLoaded(dataList));
        } else {
          emit(AppStateError(' AppEventFetchData Failed to fetch data'));
        }
      } catch (e) {
        emit(AppStateError('AppEventFetchData Error = $e'));
      }
    });
  }
}

class AppEventFetchData extends AppEvent {
  @override
  List<Object?> get props => [];
}