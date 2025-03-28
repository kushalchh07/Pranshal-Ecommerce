import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../../data/repositories/brand_repository.dart';

part 'brandproduct_event.dart';
part 'brandproduct_state.dart';

class BrandproductBloc extends Bloc<BrandproductEvent, BrandproductState> {
  final BrandRepository repository;
  BrandproductBloc(this.repository) : super(BrandproductInitial()) {
    on<FetchBrandProductEvent>((event, emit) async {
      log("FetchBrand bloc triggered");
      emit(BrandproductLoading());

      try {
        log("try bhitra brand product bloc");
        final products = await repository.fetchProductsByBrand(event.brandId);
        emit(BrandproductLoaded(products));
      } catch (e) {
        log("Error Aayo hai : $e");
        emit(BrandproductError());
      }
    });
  }
}
