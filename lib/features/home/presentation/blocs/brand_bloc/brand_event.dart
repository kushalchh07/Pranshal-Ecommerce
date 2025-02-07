part of 'brand_bloc.dart';

sealed class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}
class BrandSearchEvent extends BrandEvent {
  final String query;

  BrandSearchEvent({required this.query});
}