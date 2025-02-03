part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageLoading extends HomePageState {}

final class HomePageLoaded extends HomePageState {

   final HomeModel homeResponse;
  HomePageLoaded({required this.homeResponse});
}

final class HomePageError extends HomePageState {
  final String message;

  HomePageError({required this.message});
}
