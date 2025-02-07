part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Category> categories;

  CategoryLoadedState({required this.categories});
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState({required this.error});
}