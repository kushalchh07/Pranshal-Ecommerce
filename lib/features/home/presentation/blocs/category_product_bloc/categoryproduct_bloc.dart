import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home_model.dart';
import '../../../data/repositories/category_repository.dart';

part 'categoryproduct_event.dart';
part 'categoryproduct_state.dart';

class CategoryproductBloc
    extends Bloc<CategoryproductEvent, CategoryproductState> {
  final CategoryRepository repository;
  CategoryproductBloc(this.repository) : super(CategoryproductInitial()) {
    on<FetchCategoryProduct>((event, emit) async {
      log("FetchBrand bloc triggered");
      emit(CategoryproductLoading());

      try {
        log("try bhitra brand product bloc");
        final products = await repository.fetchProductsByCategory(event.categoryId);
        emit(CategoryProductLoaded(products));
      } catch (e) {
        log("Error Aayo hai : $e");
        emit(CategoryproductError());
      }
    });
  }
}
