part of 'brandproduct_bloc.dart';

sealed class BrandproductEvent extends Equatable {
  const BrandproductEvent();

  @override
  List<Object> get props => [];
}

final class FetchBrandProductEvent extends BrandproductEvent {
  final int brandId;
  const FetchBrandProductEvent({required this.brandId});
}


