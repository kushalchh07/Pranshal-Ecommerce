part of 'fetchorder_bloc.dart';

sealed class FetchorderEvent extends Equatable {
  const FetchorderEvent();

  @override
  List<Object> get props => [];
}
class LoadUserOrdersEvent extends FetchorderEvent {
  final int userId;

  LoadUserOrdersEvent(this.userId);

  @override
  List<Object> get props => [userId];
}