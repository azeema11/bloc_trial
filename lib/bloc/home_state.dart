part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeCompleteState extends HomeState {
  String data;
  HomeCompleteState(this.data);
}

class HomeFailureState extends HomeState{
  String message;
  HomeFailureState(this.message);
} 