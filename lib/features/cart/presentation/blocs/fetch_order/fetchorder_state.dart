part of 'fetchorder_bloc.dart';

sealed class FetchorderState extends Equatable {
  const FetchorderState();
  
  @override
  List<Object> get props => [];
}

final class FetchorderInitial extends FetchorderState {}

class FetchOrderLoadingState extends FetchorderState {}

class FetchOrderLoadedState extends FetchorderState {
  final List<OrderGet> orders;

  FetchOrderLoadedState({required this.orders});

  @override
  List<Object> get props => [orders];
}

class FetchOrderErrorState extends FetchorderState {
  final String message;

  FetchOrderErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
