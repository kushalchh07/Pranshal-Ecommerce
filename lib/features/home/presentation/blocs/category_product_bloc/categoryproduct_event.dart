part of 'categoryproduct_bloc.dart';

sealed class CategoryproductEvent extends Equatable {
  const CategoryproductEvent();

  @override
  List<Object> get props => [];
}
final class FetchCategoryProduct extends CategoryproductEvent {
  final int categoryId;
  const FetchCategoryProduct({required this.categoryId});
}
