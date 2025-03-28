part of 'brandproduct_bloc.dart';

sealed class BrandproductState extends Equatable {
  const BrandproductState();
  
  @override
  List<Object> get props => [];
}

final class BrandproductInitial extends BrandproductState {}

final class BrandproductLoading extends BrandproductState {}

final class BrandproductLoaded extends BrandproductState {
  final List<Product> brandProducts;
  const BrandproductLoaded(this.brandProducts);
  @override
  List<Object> get props => [brandProducts];
}

final class BrandproductError extends BrandproductState {}

final class BrandproductEmpty extends BrandproductState {}

final class BrandproductNotFound extends BrandproductState {}

final class BrandproductNoInternet extends BrandproductState {}

