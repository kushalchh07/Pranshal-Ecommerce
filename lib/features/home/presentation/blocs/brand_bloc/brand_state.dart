part of 'brand_bloc.dart';

sealed class BrandState extends Equatable {
  const BrandState();
  
  @override
  List<Object> get props => [];
}

class BrandInitialState extends BrandState {}

class BrandLoadingState extends BrandState {}

class BrandLoadedState extends BrandState {
  final List<Brand> brands;

  BrandLoadedState({required this.brands});
}

class BrandErrorState extends BrandState {
  final String error;

  BrandErrorState({required this.error});
}
