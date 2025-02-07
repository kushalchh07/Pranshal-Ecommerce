import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home_model.dart';
import '../../../data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    final productRepository = ProductRepository();
    on<ProductSearchEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await productRepository.searchProducts(event.query);
        emit(ProductLoadedState(products: products));
      } catch (e) {
        emit(ProductErrorState(error: e.toString()));
      }
    });
  }
}
